#!/bin/bash

function display_elf_header_info() {
    echo "ELF Header Information for '$file_name':"
    echo "----------------------------------------"
    echo "Magic Number: $magic_number"
    echo "Class: $class"
    echo "Byte Order: $byte_order"
    echo "Entry Point Address: $entry_point_address"
}
                                                                                                                                                             
┌──(kali㉿kali)-[~/Downloads]
└─$ cat get_entry_point.sh 
#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <file>"
    exit 1
fi

file_name="$1"

if [ ! -f "$file_name" ]; then
    echo "Error: File '$file_name' does not exist."
    exit 1
fi

if ! readelf -h "$file_name" &>/dev/null; then
    echo "Error: '$file_name' is not a valid ELF file."
    exit 1
fi

header=$(readelf -h "$file_name")

magic_number=$(echo "$header" | grep "Magic:" | awk -F':' '{print $2}' | xargs)
class=$(echo "$header" | grep "Class:" | awk -F':' '{print $2}' | xargs)
byte_order=$(echo "$header" | grep "Data:" | awk -F':' '{print $2}' | xargs)
entry_point_address=$(echo "$header" | grep "Entry point address:" | awk -F':' '{print $2}' | xargs)

source ./messages.sh
display_elf_header_info
