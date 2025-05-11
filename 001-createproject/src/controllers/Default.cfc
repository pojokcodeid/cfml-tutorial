
component extends="core.BaseController" {
    
    public function init() {
        return this;
    }

    public void function index() {
        // cfcontent(reset="true", type="text/html");
        // writeOutput("<style>
        //     body {
        //         display: flex;
        //         justify-content: center;
        //         align-items: center;
        //         height: 100vh;
        //     }
        // </style>");
        // writeOutput("<div style='text-align: center; color: red'>");
        // writeOutput("<h2>Oops! Something went wrong.</h2>");
        // writeOutput("<p>page not found</p>");
        // writeOutput("</div>");
        redirect("/employee");

    }
    
}