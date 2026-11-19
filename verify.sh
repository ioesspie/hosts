
#!/bin/bash

verify-IP() {
    name=$1

    nslookup "$name" | grep "$expected_ip" > /dev/null

    if [ "$?" -eq "0" ]; then
        return 0
    else
        echo "Bogus IP for $name in $hosts_file!"
        return 1
    fi
}

# Check whether a filename was provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <hosts_file>"
    exit 1
fi

hosts_file=$1

# Check whether the file exists
if [ ! -f "$hosts_file" ]; then
    echo "Error: File '$hosts_file' does not exist!"
    exit 1

fi

while read ip name
do
    case "$ip" in
        "" | \#* | *:*)
            ;;
        *)
            expected_ip=$ip
            verify-IP "$name"
            ;;
    esac
done < "$hosts_file"

exit 0
Lupascu Eduardo Stefan
