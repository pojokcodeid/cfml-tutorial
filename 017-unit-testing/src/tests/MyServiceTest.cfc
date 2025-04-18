component extends="testbox.system.BaseSpec" {

    function run() {
        describe( "MyService Test", function() {

            it( "should sum two numbers correctly", function() {
                myService = new models.MyService();
                expect( myService.sum(2, 3) ).toBe(5);
            });

        });
    }
}
