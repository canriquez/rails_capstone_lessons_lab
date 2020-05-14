// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
//= require jquery3
//= require popper
//= require bootstrap

/* Fixing turbolink preventing for functions working after redirections from controller */

$(document).on('turbolinks:load', function () {

    /* Handling groups#index course display */

    $(function () {
        $("#enabled-tab").click(function (r) {
            r.preventDefault();
            console.log('hey, SOmeone clicked enabled tab')
            $('#enabled-courses').removeClass('disabled');
            $('#enabled-courses').addClass('enabled');
            $('#disabled-courses').removeClass('enabled');
            $('#disabled-courses').addClass('disabled');
            $('#disabled-tab').removeClass('active')
            $('#enabled-tab').addClass('active')
        });

        $("#disabled-tab").click(function (r) {
            r.preventDefault();
            console.log('hey, SOmeone clicked disabled tab')
            $('#enabled-courses').removeClass('enabled');
            $('#enabled-courses').addClass('disabled');
            $('#disabled-courses').removeClass('disabled');
            $('#disabled-courses').addClass('enabled');
            $('#enabled-tab').removeClass('active')
            $('#disabled-tab').addClass('active')
        });
    });


    // Method to enable/disable courses in the groups#index page

    $(function () {
        $('.sw').on('click', function (event) {
            console.log('Yep, finding the click' + $(event.target))
            if ($(event.currentTarget).hasClass('course-on-btn')) {
                var id = (this.id).substring(3, ((this.id).length))
                var is_enabled = false;
            }

            if ($(event.currentTarget).hasClass('course-off-btn')) {
                var id = (this.id).substring(3, ((this.id).length))
                var is_enabled = true;
            }

            Rails.ajax({
                url: '/groups/' + id,
                type: "PATCH",
                data: 'group[enabled]=' + is_enabled,
                success: function (data) {
                    console.log(data);
                }
            });
        });
    });


    //Dynamic select box populator for enrolled students

    $(function () {

        //clean the enrolled student option on page load and touch (this is specially helpful if teacher change courses)
        if ($("select#transaction_sitting_student_id").val() == "") {
            $("select#transaction_sitting_student_id option").remove();
            var row = "<option value=\"" + "" + "\">" + "Select Course to see enrolled Students" + "</option>";
            $(row).appendTo("select#transaction_sitting_student_id");
        }
        $("select#transaction_course_taught_id").change(function () {
            var id_value_string = $(this).val();
            console.log('id_value_string_is :' + id_value_string)
            if (id_value_string == "") {
                $("select#transaction_sitting_student_id option").remove();
                var row = "<option value=\"" + "" + "\">" + "You have to select a valid course" + "</option>";
                $(row).appendTo("select#transaction_sitting_student_id");
            } else {
                // Send the request and update course dropdown
                Rails.ajax({
                    url: '/enrolled/' + id_value_string,
                    type: "GET",
                    error: function (XMLHttpRequest, errorTextStatus, error) {
                        alert("Failed to submit : " + errorTextStatus + " ;" + error + "value string :" + id_value_string);
                    },
                    success: function (data) {
                        console.log('it responds from the success_line')
                        // Clear all options from course select
                        $("select#transaction_sitting_student_id option").remove();
                        //put in a empty default line
                        var row = "<option value=\"" + "" + "\">" + "" + "</option>";
                        $(row).appendTo("select#transaction_sitting_student_id");
                        // Fill course select
                        myArray = []
                        $.each(data, function (i, j) {
                            row = "<option value=\"" + j.id + "\">" + j.name + "</option>";
                            console.log(row)
                            $(row).appendTo("select#transaction_sitting_student_id");
                        });

                    }
                });
            }
        });

    });

});
