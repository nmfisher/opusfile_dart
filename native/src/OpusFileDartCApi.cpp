#include <iostream>
#include "ogg/ogg.h"
#include "opusfile.h"

extern "C"
{

    unsigned char* opusfile_dart_decode(void *const encoded, size_t length, int64_t* outLength)
    {
        OggOpusFile *of;

        int ret = 0;

        of = op_open_memory((const unsigned char *)encoded, length, &ret);
        if (of == NULL)
        {
            return nullptr;
        }

        if (!op_seekable(of)) {
            std::cout << "File is not seekable" << std::endl;
            return nullptr;
        }
         
        ogg_int64_t duration = op_pcm_total(of, -1);
        opus_int64 size = size = op_raw_total(of, -1);

        unsigned char* out = (unsigned char*)malloc(duration * 2);
        int written = 0;

        *outLength = duration;

        ogg_int64_t pcm_offset;
        ogg_int64_t nsamples;
        opus_int32 bitrate;
        int prev_li;
        prev_li = -1;
        nsamples = 0;
        pcm_offset = op_pcm_tell(of);
        if (pcm_offset != 0)
        {
            fprintf(stderr, "Non-zero starting PCM offset: %li\n", (long)pcm_offset);
        }

        bitrate = 0;

        for (;;)
        {
            ogg_int64_t next_pcm_offset;
            opus_int16 pcm[120 * 48 * 2];

            int li;
            int si;

            ret = op_read_stereo(of, pcm, sizeof(pcm) / sizeof(*pcm));
            if (ret == OP_HOLE)
            {
                fprintf(stderr, "\nHole detected! Corrupt file segment?\n");
                continue;
            }
            else if (ret < 0)
            {
                ret = EXIT_FAILURE;
                break;
            }

            li = op_current_link(of);
            if (li != prev_li)
            {
                const OpusHead *head;
                const OpusTags *tags;
                int binary_suffix_len;
                int ci;

                head = op_head(of, li);

                if (!op_seekable(of))
                {
                    pcm_offset = op_pcm_tell(of) - ret;
                    if (pcm_offset != 0)
                    {
                        fprintf(stderr, "Non-zero starting PCM offset in link %i: %li\n",
                                li, (long)pcm_offset);
                    }
                }
            }
            if (li != prev_li)
            {
                opus_int32 next_bitrate;
                opus_int64 raw_offset;
                next_bitrate = op_bitrate_instant(of);
                if (next_bitrate >= 0)
                    bitrate = next_bitrate;
                raw_offset = op_raw_tell(of);
            }
            next_pcm_offset = op_pcm_tell(of);
            if (pcm_offset + ret != next_pcm_offset)
            {
                fprintf(stderr, "\nPCM offset gap! %li+%i!=%li\n",
                        (long)pcm_offset, ret, (long)next_pcm_offset);
            }

            memcpy((void*)(out+written), pcm, ret * 2 * 2); // 2 channels * 2 bytes per channel

            written += 2 * 2 * ret;
                        
            pcm_offset = next_pcm_offset;
            if (ret <= 0)
            {
                ret = EXIT_SUCCESS;
                break;
            }

            nsamples += ret;
            prev_li = li;
        }
        if (op_seekable(of) && nsamples != duration)
        {
            fprintf(stderr, "\nWARNING: "
                            "Number of output samples does not match declared file duration.\n");
        }
        op_free(of);
        return out;
    }

    void opusfile_dart_free(unsigned char* decoded) { 
        free(decoded);
    }

}
