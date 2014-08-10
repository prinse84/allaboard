// Similar to the example above, defines a "Basic" toolbar with only one strip containing three buttons.
// Note that this setting is composed by "toolbar_" added to the toolbar name, which in this case is called "Basic".
// This second part of the setting name can be anything. You must use this name in the CKEDITOR.config.toolbar setting
// in order to instruct the editor which `toolbar_(name)` setting should be used.
CKEDITOR.config.toolbar_Basic = [
	{ name: 'clipboard', items: [ 'Cut', 'Copy', 'Paste', '-', 'Undo', 'Redo' ] },
    { name: 'basicstyles', items: [ 'Bold', 'Italic','Underline' ] },
	{ name: 'links', items : [ 'Link','Unlink' ] },
	{ name: 'paragraph', items : [ 'NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote', '-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock','-','BidiLtr','BidiRtl' ] }
];

// Load toolbar_Name where Name = Basic.
CKEDITOR.config.toolbar = 'Basic';

CKEDITOR.config.removePlugins = 'elementspath';
CKEDITOR.config.resize_enabled = false;