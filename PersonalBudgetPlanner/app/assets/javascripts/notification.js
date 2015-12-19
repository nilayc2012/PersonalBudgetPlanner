 function createSelect() {

    var myDiv = document.getElementById("notification_div");
    var selectList = document.createElement("select");
    selectList.id = "mySelect";
    myDiv.appendChild(selectList);

    <% @notifications.each do |notification|%>
    var option = document.createElement("option");
    option.value = <%=notification%>;
    option.text = <%=notification%>;
    selectList.appendChild(option);
    <%end %>

    };