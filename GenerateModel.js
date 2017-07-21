/*
Script to generate Django Model classes (Python) from a MongoDB. Basically generates a schema. 

Instructions:
Change const values to your preference.
To run use command:  mongo --quiet GenerateModel.js > result.txt 
*/

const numberOfUsers = 10000; //Number of users to scan.
const dbName = "db"; //Name of database.

conn = new Mongo();
db = conn.getDB(dbName);

var existingElements = [];

var cursor = db.users.find().limit(numberOfUsers);
while( cursor.hasNext() ){
   printSchema(cursor.next(), ",");
}

function printSchema(obj, indent) {
    for (var key in obj) {
        if(typeof obj[key] != "function"){     //we don't want to print functions
            var type =typeof obj[key];
			if(type === "object"){						
			    var specificDataTypes=[Date,Array];    //specify the specific data types you want to check
				for(var i in specificDataTypes){       // looping over [Date,Array]
					if(obj[key] instanceof specificDataTypes[i]){      //if the current property is instance of the DataType
                        type = specificDataTypes[i].name;  //get its name												
                        break;
					}
				}
			}             
			
			var str = '';            
			switch(type){
				case 'boolean':
					str = "BooleanField(required=False)";
					break;
				
				case 'string':
					str = "StringField(required=False)";
					break;
					
				case 'number':
					str = "IntField(required=False, default=0)";
					break;
					
				case 'Array':
					str = "ListField(default=[])";
					break;
					
				case 'Date':
					str = "DateTimeField(required=False)";
					break;
			}						
			
			var item = key + " = " + str;			
			if(existingElements.indexOf(item) > -1){
				
			} else {
				existingElements.push(item);
				print(item);
			}
        }
    }
};
	
	
