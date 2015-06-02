var ipc=require('node-ipc');

ipc.config.id   = 'world';
ipc.config.retry= 1500;

ipc.serve(
    function(){
        ipc.server.on(
            'message',
            function(data,socket){
                ipc.log('got a message : '.debug, data);
                ipc.server.emit(
                    socket,
                    'message',
                    data+' world!'
                );

                setInterval(function() {
                  ipc.server.emit(
                      socket,
                      'message',
                      data+' world!'
                  );
                }, 30000);
            }
        );
    }
);

ipc.server.start();
