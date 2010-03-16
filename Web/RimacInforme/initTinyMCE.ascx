<%@ Control Language="C#" AutoEventWireup="true" CodeFile="initTinyMCE.ascx.cs" Inherits="RimacInforme_initTinyMCE" %>
<script type="text/javascript">
    jQuery(function() {
        $('textarea.tinymce-full').tinymce({
            // Location of TinyMCE script
            script_url: '',

            // General options
            theme: "advanced",
            plugins: "safari,pagebreak,style,layer,table,save,advhr,advimage,advlink,emotions,iespell,inlinepopups,insertdatetime,preview,media,searchreplace,print,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template",

            // Theme options
            theme_advanced_buttons1: "save,newdocument,|,bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,styleselect,formatselect,fontselect,fontsizeselect",
            theme_advanced_buttons2: "cut,copy,paste,pastetext,pasteword,|,search,replace,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,anchor,image,cleanup,help,code,|,insertdate,inserttime,preview,|,forecolor,backcolor",
            theme_advanced_buttons3: "tablecontrols,|,hr,removeformat,visualaid,|,sub,sup,|,charmap,emotions,iespell,media,advhr,|,print,|,ltr,rtl,|,fullscreen",
            theme_advanced_buttons4: "insertlayer,moveforward,movebackward,absolute,|,styleprops,|,cite,abbr,acronym,del,ins,attribs,|,visualchars,nonbreaking,template,pagebreak",
            theme_advanced_toolbar_location: "top",
            theme_advanced_toolbar_align: "left",
            theme_advanced_statusbar_location: "bottom",
            theme_advanced_resizing: true,           

            // Drop lists for link/image/media/template dialogs
            /*template_external_list_url: "lists/template_list.js",
            external_link_list_url: "lists/link_list.js",
            external_image_list_url: "lists/image_list.js",
            media_external_list_url: "lists/media_list.js",*/

            // Replace values for the template plugin
            template_replace_values: {
                username: "RGEN",
                staffid: "991234"
            },
            width: "825"
            
        });

        $('textarea.tinymce-simple').tinymce({
            // Location of TinyMCE script
            script_url: '',

            // General options
            theme: "advanced",
            plugins: "safari,advlink,inlinepopups,insertdatetime,media,searchreplace,print,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template",

            // Theme options
            theme_advanced_buttons1: "bold,italic,underline,|,justifyleft,justifycenter,justifyright,justifyfull, cut,copy,paste,pastetext,pasteword,|,search,replace,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,fullscreen",
            theme_advanced_buttons2: "",
            theme_advanced_buttons3: "",
            theme_advanced_buttons4: "",
            theme_advanced_toolbar_location: "top",
            theme_advanced_toolbar_align: "left",
            theme_advanced_statusbar_location: "bottom",
            theme_advanced_resizing: true,

            // Drop lists for link/image/media/template dialogs
            /*template_external_list_url: "lists/template_list.js",
            external_link_list_url: "lists/link_list.js",
            external_image_list_url: "lists/image_list.js",
            media_external_list_url: "lists/media_list.js",*/

            // Replace values for the template plugin
            template_replace_values: {
                username: "RGEN",
                staffid: "991234"
            },
            width: "825",
			setup : function(ed) {
				// Gets executed after DOM to HTML string serialization
				ed.onPostProcess.add(function(ed, o) {
					// State get is set when contents is extracted from editor
					//if (o.get) {
						// Replace all strong/b elements with em elements
						//o.content = o.content.replace(/<(strong|b)([^>]*)>/g, '');						
					o.content = o.content.replace(/width\s*=\s*["']\s*\d*\s*(px|%)*["']/g, '');
					o.content = o.content.replace(/height\s*=\s*["']\s*\d*\s*(px|%)*["']/g, '');
					
					var $content = $('<div></div>');
					$content.append(o.content);
					$content.find('*').attr('style','');
					$content.find('table').removeAttr('width').css('width','100%');
					$content.find('td').removeAttr('width').attr('style','');
					//$content.find('table tr td:first').css('width', '70%').css('width','30%');
					
					o.content = $content.html();
					//}
				});
			}
            
        });
    });
</script>