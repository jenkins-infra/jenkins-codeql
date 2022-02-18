This check identified one of several methods being invoked. Jenkins plugins generally should not call any of these methods. While there may be legitimate use cases, care needs to be taken that these don't cause problems.

* `java.lang.System#exit`
* `java.lang.Runtime#exec`
* `javax.net.ssl.SSLContext#init`
* `javax.net.ssl.HttpsURLConnection#setDefaultSSLSocketFactory`
* `javax.net.ssl.HttpsURLConnection#setDefaultHostnameVerifier`
* `javax.net.ssl.HttpsURLConnection#setHostnameVerifier`
* `javax.net.ssl.HttpsURLConnection#setSSLSocketFactory`

See the [documentation on misc APIs](https://www.jenkins.io/doc/developer/security/misc/).
