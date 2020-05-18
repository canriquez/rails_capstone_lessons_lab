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

    /* Handling transactions#index bookings display */

    $(function () {
        $("#enabled-tab").click(function (r) {
            r.preventDefault();
            console.log('hey, SOmeone clicked enabled tab')
            $('#billable-bb').removeClass('disabled');
            $('#billable-bb').addClass('enabled');
            $('#non-billable-bb').removeClass('enabled');
            $('#non-billable-bb').addClass('disabled');
            $('#disabled-tab').removeClass('active')
            $('#enabled-tab').addClass('active')
        });

        $("#disabled-tab").click(function (r) {
            r.preventDefault();
            console.log('hey, SOmeone clicked disabled tab')
            $('#billable-bb').removeClass('enabled');
            $('#billable-bb').addClass('disabled');
            $('#non-billable-bb').removeClass('disabled');
            $('#non-billable-bb').addClass('enabled');
            $('#enabled-tab').removeClass('active')
            $('#disabled-tab').addClass('active')
        });
    });


    // Method to enable/disable courses in the groups#index page

    $(function () {
        $('.sw').on('click', function (event) {
            console.log('Yep, finding the click. Handling: enable/disable course' + $(event.target))
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

    //************* Dynamic select box populator for not_enrolled in students ***********

    $(document).ready(function () {
        var wait = false;
        var x = 0
        // Populates selector to add new enrolled student to course (not previously enrolled in that course)

        $('.enroll').on('click', debounce(function (event) {
            console.log(" .enroll click detected")
            console.log('Yep, finding the click' + $(event.currentTarget))

            if ($(event.target).hasClass('enroll') && $(event.target).not('.working') && !wait) {
                $(event.target).addClass('working');
                x += 1
                console.log('clicks :' + x)
                console.log('bloquing selector - we are now Working')
                var id_value_string = (event.target.id).substring(4, ((event.target.id).length))
                console.log('we click on a enroll - selector :' + id_value_string)

                // Send the request and update course dropdown
                Rails.ajax({
                    url: '/enrolar/' + id_value_string,
                    type: "GET",
                    error: function (XMLHttpRequest, errorTextStatus, error) {
                        alert("Failed to submit : " + errorTextStatus + " ;" + error + "value string :" + id_value_string);
                    },
                    success: function (data) {
                        console.log('it responds from the success_line')
                        // Clear all options from course select
                        var string_selector = "select#abc-" + id_value_string + " option"
                        $(string_selector).remove();
                        //put in a empty default line
                        var row = "<option value=\"" + "" + "\">" + "" + "</option>";
                        $(row).appendTo("select#abc-" + id_value_string);
                        // Fill course select
                        myArray = []
                        $.each(data, function (i, j) {
                            row = "<option value=\"" + j.id + "\">" + j.name + "</option>";
                            console.log(row)
                            $(row).appendTo("select#abc-" + id_value_string);
                        });

                    }
                });
            } else {
                console.log('Not catching the class enroll')
                //$(event.target).removeClass('working');
                console.log('un-bloquing selector - we can choose again now')
            }
        }, 250));

        // Catched the add student button and fires up the PUT update enrolls action 

        $('.add-student').on('click', debounce(function (event) {
            console.log("click on add button detected")

            if ($(event.target).hasClass('add-student') && $(event.target).not('.working') && !wait) {
                //$(event.target).addClass('working');
                var id_value_string = (event.target.id).substring(4, ((event.target.id).length))
                $(event.target).addClass('working');
                //alert('id : ' + event.target.id + ' has .working ? : ' + $(event.target).hasClass('working'))
                console.log('we click on a ADD student  - selector :' + id_value_string)

                console.log("student_id :" + $("select#abc-" + id_value_string).val());
                var student_id = $("select#abc-" + id_value_string).val()
                if (student_id != "" && student_id != "Choose...") {
                    console.log("we have a correct value")

                    // Send the request and update course dropdown
                    Rails.ajax({
                        url: '/enrolls',
                        type: "POST",
                        data: 'student_id=' + student_id + '&course_id=' + id_value_string,
                        error: function (XMLHttpRequest, errorTextStatus, error) {
                            alert("Failed to submit : " + errorTextStatus + " ;" + error + "value string :" + id_value_string);
                        },
                        success: function (data) {
                            console.log('We successfully recorded enrolled :' + student_id + ':' + id_value_string)
                            //$(event.target).removeClass('working');

                        }
                    });
                };
            } else {
                console.log('Not catching the class add-student')
                wait = false
            }
        }, 250));




    });


    //Disable/enable billable/non-billable option on Transaction new form

    $(function () {

        //clean the enrolled student option on page load and touch (this is specially helpful if teacher change courses)
        if ($("select#inputBillableGroup").val() == "1") {
            $("select#transaction_course_taught_id").prop("disabled", false);
            $("select#transaction_sitting_student_id").prop("disabled", false);
        }

        $("select#inputBillableGroup").change(function () {
            var id_value_string = $(this).val();
            console.log('id_value_string_is :' + id_value_string)
            if (id_value_string == "2") {
                $("select#transaction_course_taught_id").prop("disabled", true);
                $("select#transaction_sitting_student_id").prop("disabled", true);
            } else {
                $("select#transaction_course_taught_id").val = '';
                $("select#transaction_sitting_student_id").val = '';
                $("select#transaction_course_taught_id").prop("disabled", false);
                $("select#transaction_sitting_student_id").prop("disabled", false);
            }
        });

    });

});

function debounce(func, wait, immediate) {
    var timeout;
    return function () {
        var context = this, args = arguments;
        var later = function () {
            timeout = null;
            if (!immediate) func.apply(context, args);
        };
        var callNow = immediate && !timeout;
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
        if (callNow) func.apply(context, args);
    };
};
