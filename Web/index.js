$(document).ready(function(){
    // UI section

    if(sessionStorage.getItem('sessionID') != null){
        $('#allow-container').css({
            'display' : 'none'
        })
        $('#controller').addClass('controller-active')
    }

    resize();
    function resize(){
        window.resizeTo(850, 690);
    }
    $('#reg-btn').click(function(){
        $('#circle-anim').addClass('circ-active')
    })
    $('#log-btn').click(function(){
        $('#width-anim').addClass('width-active')
    })
    $('.back').click(function(){
        $('#circle-anim').removeClass('circ-active')
        $('#width-anim').removeClass('width-active')
        document.getElementById('reg-form-id').reset();
        document.getElementById('log-in-form').reset();
    })
    $('#resize').click(function(){
        resize()
    })
    $('#location').click(function(){
        $('#map').addClass('map-active')
        $('.leaflet-right').addClass('leaf-active')
        $('#close-map').addClass('active-close')
    })
    $('#close-map').click(function(){
        $('#map').removeClass('map-active')
        $('.leaflet-right').removeClass('leaf-active')
        $('#close-map').removeClass('active-close')
    })
    var marker = {}
    var map = L.map('map').setView([10.639181, 122.977394], 7);
    L.Control.geocoder({
        defaultMarkGeocode: false,
    }).on('markgeocode', function(e){
        map.removeLayer(marker)
        marker = L.marker([e.geocode.center.lat, e.geocode.center.lng], 30).addTo(map)
        .bindPopup('Set this as Establishment\'s Location?'+'<br>'+'<button class="map-btn">Get Location</button>')
        .openPopup()
        $('.map-btn').click(function(){
            $('.map-btn').addClass('bgc-4').html('Saved')
            $('#loc-input').val(e.geocode.center.lat +','+ e.geocode.center.lng)
        })
        map.fitBounds(e.geocode.bbox)
    }).addTo(map);
    map.on("click", function(e){
        lat = e.latlng.lat;
        long = e.latlng.lng;
        if (marker != undefined){
            map.removeLayer(marker)
        }
        marker = L.marker([lat, long]).addTo(map)
            .bindPopup('Set this as Establishment\'s Location?'+'<br>'+'<button class="map-btn">Get Location</button>')
            .openPopup()
            $('.map-btn').click(function(){
                $('.map-btn').addClass('bgc-4').html('Saved')
                $('#loc-input').val(e.latlng.lat +','+ e.latlng.lng)
            })
    })
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
    }).addTo(map);

    //register section

    $('.animated-btn').click(function(){
        $('#loading-box').css({'height' : '0%'});
        $('#loading-widget').css({
            'border-radius' : '2px',
            'background-color' : 'transparent'
        })
        $('.animated-btn').css({
            'pointer-events' : 'none',
        }).html('Please wait!')
        document.getElementById('reg-form-id').reset();
        document.getElementById('log-in-form').reset();
        if(sessionStorage.getItem('sessionID') != null){
            $('#allow-container').css({
                'display' : 'none'
            })
            $('#width-anim').removeClass('width-active')
            $('#controller').addClass('controller-active')
        }
    })

    $('#reg-form-id').submit(function(e){
        e.preventDefault()
        $('#loading-box').css({'height' : '100%'})
        var raw_data = $(this).serializeArray()
        data = {
            'data' : true,
            'est_name' : raw_data[0],
            'city': raw_data[1],
            'branch': raw_data[2],
            'brgy': raw_data[3],
            'latlong': raw_data[4],
            'type': raw_data[5],
            'username': raw_data[6],
            'password': raw_data[7]
        }
        eel.get_form_data_register(data);
    });
    
    eel.expose(read_status_py);
    function read_status_py(status){
        if(status == 'Registration Success'){
            setTimeout(function(){
                $('#loading-widget').css({
                    'border-radius' : '50%',
                    'background-color' : '#86e3ce'
                })
                $('.animated-btn').css({
                    'pointer-events' : 'auto',
                }).html('Complete!')
            }, 3000)
        }else{
            setTimeout(function(){
                $('#loading-widget').css({
                    'border-radius' : '50%',
                    'background-color' : '#86e3ce'
                })
                $('.animated-btn').css({
                    'pointer-events' : 'auto',
                }).html('Username taken')
            }, 3000)
        }
    }

    var store_id = '';

    $('#log-in-form').submit(function(e){
        e.preventDefault();
        $('#loading-box').css({'height' : '100%'})
        var raw_data = $(this).serializeArray();
        var data = {
            'data' : true,
            'user-login' : raw_data[0],
            'pass-login' : raw_data[1]
        }
        eel.get_form_data_login(data)
    })

    eel.expose(read_status_login_py);
    function read_status_login_py(status){
        if(status.status == 'Log-in Success'){
            setTimeout(function(){
                $('#loading-widget').css({
                    'border-radius' : '50%',
                    'background-color' : '#86e3ce'
                })
                $('.animated-btn').css({
                    'pointer-events' : 'auto',
                }).html('Complete!')
                sessionStorage.setItem('sessionID', status.data);
            }, 3000)
        }else{
            setTimeout(function(){
                $('#loading-widget').css({
                    'border-radius' : '50%',
                    'background-color' : '#86e3ce'
                })
                $('.animated-btn').css({
                    'pointer-events' : 'auto',
                }).html('Please try again!')
            }, 3000)
        }
    }

    $('.ctrl-btn').click(function(){
        var process = $(this).attr('data-do');
        $('#snuck-bar').addClass('s-active');
        $('.ctrl-btn').children().removeClass('color-2')
        $(this).children().addClass('color-2')
        if(process == 'off'){
            var message = '<p class="color-4 font-3"> Do you want to log out? </p> <a id="log-out" class="color-4 font-2" href="#"> Yes</a><a id="snuck-no" class="color-4 font-2 snuck-no" href="#"> No</a>';
            $('#snuck-bar').html(message);
        }else if(process == 'on'){
            var message = '<p class="color-4 font-3"> Do you want to turn on the camera? </p> <a id="start_cam" class="color-4 font-2" href="#"> Yes</a><a class="color-4 font-2 snuck-no" href="#"> No</a>';
            $('#snuck-bar').html(message);
        }else if(process == 'report'){
            var message = '';
            $('#snuck-bar').html(message);
        }else if(process == 'set'){
            var message = '<p class="color-4 font-3"> Set normal capacity </p> <input id="norm_cap" type="number">' + ' <p class="color-4 font-3"> Set capacity Limitations </p> <select id="lim" value=""><option value="">-</option><option value="0.3">30%</option><option value="0.7">70%</option><option value="0.9">90%</option></select>' + ' <a id="set" class="color-4 font-2" href="#"> Yes</a><a class="color-4 font-2 snuck-no" href="#"> No</a>'
            $('#snuck-bar').html(message);
        }else if(process == 'extend'){
            var message = '<p class="color-4 font-3"> Run extended display? </p> <a id="extend" class="color-4 font-2" href="#"> Yes</a><a class="color-4 font-2 snuck-no" href="#"> No</a>';
            $('#snuck-bar').html(message);
        }
        $('.snuck-no').click(function(e){
            e.preventDefault();
            $('#snuck-bar').removeClass('s-active')
            $('.ctrl-btn').children().removeClass('color-2')
        })
        $('#log-out').click(function(e){
            e.preventDefault();
            sessionStorage.removeItem('sessionID')
            $('#allow-container').css({
                'display' : 'flex'
            })
            $('.ctrl-btn').children().removeClass('color-2')
            $('#controller').removeClass('controller-active')
            $('#snuck-bar').removeClass('s-active')
        })
        $('#set').click(function(e){
            e.preventDefault()
            var capacity = $('#norm_cap').val()
            var limit = $('#lim').find(":selected").val()
            var data = {
                'id' : sessionStorage.getItem('sessionID'),
                'cap' : capacity,
                'lim' : limit
            }
            $('.ctrl-btn').children().removeClass('color-2')
            $('#snuck-bar').removeClass('s-active')
            eel.set_settings(data)
        })
        $('#start_cam').click(function(e){
            e.preventDefault()
            $('#snuck-bar').removeClass('s-active')
            $('.ctrl-btn').children().removeClass('color-2')
            eel.start_cam(sessionStorage.getItem('sessionID'))
        })
        $('#extend').click(function(e){
            e.preventDefault();
            $('.ctrl-btn').children().removeClass('color-2')
            $('#snuck-bar').removeClass('s-active')
            eel.start_extended()
        })
    })


});

    