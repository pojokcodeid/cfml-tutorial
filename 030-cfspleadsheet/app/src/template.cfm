<cfscript>
    cfheader(name="Content-Disposition", value="attachment;filename=upload_data.xlsx");
    cfcontent(type="application/vnd.ms-excel", file=expandPath("/temp/template/upload_data.xlsx"), reset=true);
</cfscript>