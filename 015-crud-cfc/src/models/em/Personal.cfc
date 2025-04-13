component {
    
    public array function listPersonal() {
        local.personals = [];
        local.qPersonal = queryExecute(
            "SELECT id, name, email, age FROM personal"
        );
        for (var p in local.qPersonal) {
            arrayAppend(local.personals, {
                id = p.id,
                name = p.name,
                email = p.email,
                age = p.age
            });
        }
        return local.personals;
    }

    
    public struct function getPersonalById(numeric id) {
        local.qPersonal = queryExecute(
            "SELECT id, name, email, age FROM personal WHERE id = ?",
            [id]
        );
        if (local.qPersonal.recordCount) {
            return {
                id = local.qPersonal.id,
                name = local.qPersonal.name,
                email = local.qPersonal.email,
                age = local.qPersonal.age
            };
        }
        return {};
    }
    
    
    public boolean function updatePersonal(
        struct argEntries
    ) {
        local.dataToUpdate = {
            id = {value=argEntries.id, sqltype="CF_SQL_INTEGER"},
            name = {value=argEntries.name, sqltype="CF_SQL_VARCHAR"},
            email = {value=argEntries.email, sqltype="CF_SQL_VARCHAR"},
            age = {value=argEntries.age, sqltype="CF_SQL_INTEGER"}
        };
        try{
            local.qUpdate = queryExecute(
                "UPDATE personal SET name = :name, email = :email, age = :age WHERE id = :id",
                local.dataToUpdate
            );
            return true;
        } catch (any e) {
            return false;
        }
    }

    
    public boolean function addPersonal(
        struct argEntries
    ) {
        local.dataToInsert = {
            name = {value=argEntries.name, sqltype="CF_SQL_VARCHAR"},
            email = {value=argEntries.email, sqltype="CF_SQL_VARCHAR"},
            age = {value=argEntries.age, sqltype="CF_SQL_INTEGER"}
        };
        try{
            local.qInsert = queryExecute(
                "INSERT INTO personal (name, email, age) VALUES (:name, :email, :age)",
                local.dataToInsert
            );
            return true;
        } catch (any e) {
            return false;
        }
    }

    
    public boolean function deletePersonal(numeric id) {
        try{
            local.qDelete = queryExecute(
                "DELETE FROM personal WHERE id = ?",
                [id]
            );
            return true;
        } catch (any e) {
            return false;
        }
    }
    

}
