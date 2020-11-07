#!/bin/bash 
#           Name: (NAME (LONG_NAME))
#    Description: (WHAT DO I DO)
#             By: Brian Blankenship
#           Date: (DATE)
#        Version: v1.0
#
#        Log Dir: (LOG_FILEPATH)
#       Log File: (LOG_FILENAME)
#
#           MUST: (REQUIREMENTS)
#         SHOULD: (ADVICE)
#
#           NOTE:

#D="domain.com"; T="mx"; O="+short"; DELAY="60"; digdug;

digdug() { 
  while true; 
  do
    NAMESERVERS=$(dig ns $D @8.8.8.8 +short);
    [[ "$(echo -ne $NAMESERVERS|wc -w)" == "0" ]] && (
        echo "$(date "+%Y%m%d-%H:%M:%S%z") - No Name Servers Found"
        ) || (
        echo -en "\n\nThe domain $D has $(echo $NAMESERVERS|wc -w) name servers.\n"; 
        echo $NAMESERVERS; 
        for NAMESERVER in $NAMESERVERS; 
          do
            echo -en "$(date "+%Y%m%d-%H:%M:%S%z") - $D at $NAMESERVER $(echo $(dig $T $D $O @$NAMESERVER))\n" &
          done; 
      )
  sleep $DELAY;
  done;
  }
  