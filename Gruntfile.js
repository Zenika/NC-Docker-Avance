module.exports = function(grunt) {
    grunt.initConfig({
        zenika: {
            formation: {
                name: 'Nightclazz Docker Avancé'
            }
        }
    });
    grunt.loadTasks('node_modules/zenika-formation-framework');
	
    grunt.registerTask('default', ['displaySlides']);

};
