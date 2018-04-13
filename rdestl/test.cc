#include <string.h>
#include "benchmark.h"
#include "rdestl/hash_map.h"

using namespace rde;

struct eqstr {
	inline bool operator()(const char *s1, const char *s2) const {
		return strcmp(s1, s2) == 0;
    }
};

struct hashf_int {
	inline unsigned operator()(unsigned key) const {
		return key;
	}
};
struct hasheq_int {
	inline unsigned operator()(unsigned key1, unsigned key2) const {
		return key1 == key2;
	}
};

typedef rde::hash_map<unsigned, int> inthash;

int test_int(int N, const unsigned *data)
{
	int i, ret;
	inthash *h = new inthash;
	for (i = 0; i < N; ++i) {
		pair<inthash::iterator, bool> p = h->insert(pair<unsigned, int>(data[i], i));
		if (p.second == false) h->erase(p.first);
	}
	ret = h->size();
	delete h;
	return ret;
}

int test_str(int N, char * const *data)
{
	return 0;
}

int main(int argc, char *argv[])
{
	return udb_benchmark(argc, argv, test_int, test_str);
}
