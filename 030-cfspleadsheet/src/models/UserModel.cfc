component {
    
    public any function init(){
        return this;
    }

    public any function getAllUsers(){
        var users=[];
        var qry="select * from user";
        var data = queryExecute(qry);
        for(var i in data){
            arrayAppend(users, {
                nik: i.nik,
                name: i.name,
                email: i.email,
                age: i.age,
                dob: i.dob,
                jam: i.jam
            });
        }
        return users;
    }

    public any function insert(data={}){
        try{   
            transaction action="begin" {       
                for(row in data) {
                    queryExecute(
                        "insert into user(nik, name, email, age, dob, jam) 
                        values(:nik, :name, :email, :age, :dob, :jam)",
                        {
                            nik= {value=row.nik, sqltype="CF_SQL_VARCHAR"}, 
                            name= {value=row.name, sqltype="CF_SQL_VARCHAR"}, 
                            email= {value=row.email, sqltype="CF_SQL_VARCHAR"}, 
                            age= {value=row.age, sqltype="CF_SQL_INTEGER"}, 
                            dob= {value=row.dob, sqltype="CF_SQL_DATE"}, 
                            jam={value=row.jam, sqltype="CF_SQL_TIME"}
                        }
                    );
                }
            }
        }catch (any e) {
            throw(e.message);
        }
    }
}