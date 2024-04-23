#include <stddef.h>
#include <stdint.h>

unsigned char* opusfile_dart_decode(void* const encoded, size_t length, int64_t* outLength);
void opusfile_dart_free(unsigned char* decoded);
