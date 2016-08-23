HTMLWidgets.widget({

  name: 'gitgraph',

  type: 'output',

  factory: function(el, width, height) {

    var instance = {};

    return {

      renderValue: function(x) {

        var canvas = instance.canvas = document.createElement('canvas');
        canvas.setAttribute('id', el.id + "-canvas-gitgraph");
        el.appendChild(canvas);
        
        if(!x.config) x.config = {};
        
        x.config.elementId = canvas.id;
        
        var gitgraph = instance.gitgraph = new GitGraph( x.config );
        
        var data = instance.data = HTMLWidgets.dataframeToD3(x.githistory);
        var branches = {};
        
        data.map(function(action){
          // add branch if not already created
          if(!branches[action.branch]) {
            branches[action.branch] = gitgraph.branch({'name': action.branch});
          }
          
          var branch = branches[action.branch];
          
          // merge expects the branch object as an argument
          //  while commit expects an object of details
          var details = action.type === "merge" ? branch[action.details.branch] : action.details;
          
          branch[action.type](details);
        });
        
      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      },
      
      instance: instance

    };
  }
});