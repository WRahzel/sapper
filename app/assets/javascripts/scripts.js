$(function() {
    this.oncontextmenu = function() { return false; };
    // левый клик
    $('#mines').on('click', '.square', function(e) {
        // получение данных из кликнутого квадрата из свойства data-x и data-y
        x = $(this).data('x');
        y = $(this).data('y');
        // отправка POST-запроса серверу
        $.post('http://localhost:3000/square/' + x + y + '/1');
        time = my_timer.innerHTML;
        if(time == '00:00:00') startTimer(); // если таймер не запускался, то запускается
    })
    // правый клик
    .on('mousedown', '.square', function(e) {
        if(e.which == 2 || e.which == 3) {
            x = $(this).data('x');
            y = $(this).data('y');
            $.post('http://localhost:3000/square/' + x + y + '/2');
        }
    });
    // таймер
    function startTimer() {
        if($('#result').html() == '') {
            my_timer = document.getElementById('my_timer');
            time = my_timer.innerHTML;
            arr = time.split(':');
            h = arr[0];
            m = arr[1];
            s = arr[2];
            if(s == 60) {
                if(m == 60) {
                    h++;
                    if(h < 10) h = '0' + h;
                    m = 0;
                }
                m++;
                if(m < 10) m = '0' + m;
                s = 0;
            }
            else s++;
            if(s < 10) s = '0' + s;
            document.getElementById("my_timer").innerHTML = h+':'+m+':'+s;
            setTimeout(startTimer, 1000);
        }
    }
});