# Reverse aliases
alias mitmproxy="/home/$USER/dev/reverse/mitmproxy/mitmproxy"
alias mitmweb="/home/$USER/dev/reverse/mitmproxy/mitmweb"

alias apktool="/home/$USER/dev/reverse/apktool"

fingerprint() {
    eval "openssl x509 -in ~/.mitmproxy/mitmproxy-ca-cert.pem -inform pem -pubkey -noout | openssl pkey -pubin -outform der | openssl dgst -$1 -binary | openssl enc -$2"
}

alias genkeystore="keytool -genkey -v -keystore bi.keystore -alias bi -keyalg RSA -keysize 2048 -validity 10000"

apksign() {
    jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore ~/dev/reverse/bi.keystore $1 bi
}

buildapk() {
    apktool b $1 -o $(echo -n $1 | sed 's/\.\///g' | echo $(cat)'_bi.apk')
}

decompileapk() {
    apktool d -f $(echo $1)
}

pullapk() {
    if [ -z "$2" ]; then
        dest="/home/$USER/dev/reverse/apk/$1/"
    else
        dest=$2/$1/
    fi

    mkdir -p $dest

    for path in $(adb shell pm path $1 | sed 's/package://g'); do
        adb pull $path $dest
    done
}

alignapk() {
    zipalign -f -v 4 $1 $(echo -n $1 | sed 's/\.\///g' | echo $(cat)'_aligned.apk')
}
