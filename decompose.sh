# Generate files from pcapng file
# Maintains a master list of hashes and removes previously seen hashes from new hashlists

# Run in a folder specific to the one pcapng file, 1 level below ALL_PMKID.16800

filename=$(basename -- $1)
filename="${filename%.*}"

hccapx=$filename".hccapx"
text=$filename"_wordlist.txt"
pmkid=$filename"_PMKID.16800"
identity=$filename"_identity.txt"
username=$filename"_usernames.txt"
traffic=$filename"_traffic.txt"
pmklist=$filename"_PMKList.txt"


hcxpcaptool -o $hccapx -z $pmkid"Full" $1 -E $text  -I $identity -U $username -T $traffic -P $pmklist

# Remove data we already have 
../rli $pmkid"Full" $pmkid ../All_PMKID.16800

# Add our data to list
cat $pmkid >> ../All_PMKID.16800

#echo "**** "$hccapx" contains:"
#wlanhcxinfo -i output2.hccapx  -a -s -e

# whoismac -d # use this to dl
#echo "**** "$pmkid" contains:"
#for i in $(cat $pmkid ); do whoismac -p $i | grep "ESSID"; done










