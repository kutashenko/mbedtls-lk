KERNEL = /lib/modules/$(shell uname -r)/build

TARGET = mbedtls-lk
obj-m = $(TARGET).o

EXTRA_CFLAGS +=						\
	-I$(PWD)/include				\
	-I$(PWD)/mbedtls/include			\
	-I$(PWD)/configs				\
	-DMBEDTLS_CONFIG_FILE='<config-lk.h>'		\
	-include $(PWD)/lk.h				\
	-include linux/kernel.h

mbedtls-objects =					\
	aes.o		aesni.o		arc4.o		\
	asn1parse.o	asn1write.o	base64.o	\
	bignum.o	blowfish.o	camellia.o	\
	ccm.o		cipher.o	cipher_wrap.o	\
	ctr_drbg.o	des.o		dhm.o		\
	ecdh.o		ecdsa.o		ecjpake.o	\
	ecp.o						\
	ecp_curves.o	entropy.o	entropy_poll.o	\
	error.o		gcm.o		havege.o	\
	hmac_drbg.o	md.o		md2.o		\
	md4.o		md5.o		md_wrap.o	\
	memory_buffer_alloc.o		oid.o		\
	padlock.o	pem.o		pk.o		\
	pk_wrap.o	pkcs12.o	pkcs5.o		\
	pkparse.o	pkwrite.o	platform.o	\
	ripemd160.o	rsa.o		sha1.o		\
	sha256.o	sha512.o	threading.o	\
	timing.o	version.o			\
	version_features.o		xtea.o		\
	certs.o		pkcs11.o	x509.o		\
	x509_create.o	x509_crl.o	x509_crt.o	\
	x509_csr.o	x509write_crt.o	x509write_csr.o	\
	debug.o		net.o		ssl_cache.o	\
	ssl_ciphersuites.o		ssl_cli.o	\
	ssl_cookie.o	ssl_srv.o	ssl_ticket.o	\
	ssl_tls.o

$(TARGET)-objs +=					\
	lk.o						\
	main.o						\
	selftest.o					\
	$(addprefix mbedtls/library/, $(mbedtls-objects))

all:
	$(MAKE) -C $(KERNEL) M=$(PWD) modules

clean:
	$(MAKE) -C $(KERNEL) M=$(PWD) clean
