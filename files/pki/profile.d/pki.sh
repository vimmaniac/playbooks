# @param1 cert
function cf-pki-sign() {
  openssl ca -policy policy_anything -out /etc/pki/CA/certs/${1}.crt -infiles /etc/pki/CA/csr/${1}.csr
  echo "/etc/pki/CA/certs/${1}.crt"
  cat /etc/pki/CA/certs/${1}.crt
}
