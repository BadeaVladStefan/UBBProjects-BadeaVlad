$(document).ready(function(){
    $("table").on('click', '.btnDelete', function () {
        let id = $(this).closest('tr')[0].cells[0].innerText;
        $.post("delete.php",{'id': id});
        $(this).closest('tr').remove();
    });

    $("table").on('click', '.btnUpdate', function () {
        let title = $(this).closest('tr').find('td:eq(1)').text();
        let author = $(this).closest('tr').find('td:eq(2)').text();
        let numberPages = $(this).closest('tr').find('td:eq(3)').text(); 
        let type = $(this).closest('tr').find('td:eq(4)').text(); 
        let format = $(this).closest('tr').find('td:eq(5)').text(); 

        $(".update_form #title").val(title);
        $(".update_form #author").val(author);
        $(".update_form #numberPages").val(numberPages);
        $(".update_form #type").val(type);
        $(".update_form #format").val(format);

        if($(".update_form").css("display") === "none")
            $(".update_form").css("display", "inline");
        else
            $(".update_form").css("display", "none");
    });
});