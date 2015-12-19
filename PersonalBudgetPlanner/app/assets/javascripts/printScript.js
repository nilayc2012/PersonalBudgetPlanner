function printData()
{
   var table=document.getElementById("printTable");
   var rowCount = table.rows.length;  
   newWin= window.open("");
   newWin.document.write("<table border='3'>");
   for (var c = 0, m = table.rows[0].cells.length; c < m-1; c++) {
   newWin.document.write("<th>"+table.rows[0].cells[c].innerHTML+"</th>");}
   
   for (var r = 1, n = table.rows.length; r < n; r++) {
	  newWin.document.write("<tr>");
    for (var c = 0, m = table.rows[r].cells.length; c < m-1; c++) {
	  newWin.document.write("<td align='center'>"+table.rows[r].cells[c].innerHTML+"</td>");
	  }
   newWin.document.write("</tr>"); }
   newWin.document.write("</table>");
   newWin.print();
   newWin.close();
}