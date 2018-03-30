import ballerina/io;
import ballerina/util;

function main (string[] args) {
    //Create JSON.

while (true) {

    string passwdHash = util:base64Encode("TEST123");
    json j1 = {"User":{
                           "empid":"0100",
                           "name":"Sashika",
                           "address":{
                                "Num":"20",
                                "street":"Palm Grove",
                                "city":"colombo 03",
                                "province":"Western province",
                                "postalCode":"00300"
                                     },
                           "phone":["+9400000000", "+94111111"],
                           "password":passwdHash,
                           "accounts":{
                                "types":{
                                        "regular":{
                                                "id":"0001",
                                                "permissions":{
                                                        "login":"yes",
                                                        "read":"no",
                                                        "edit":"no"
                                                }
                                        }
                                }
                           }
                       }
              };
    //Convert to XML with default attribute prefix and arrayEntryTag.
    var x1 = j1.toXML({});
}
}
