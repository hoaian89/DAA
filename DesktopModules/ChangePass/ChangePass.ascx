<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ChangePass.ascx.cs" Inherits="DesktopModules_ChangePass_ChangePass" %>

<canvas id="myCanvas">Your browser does not support the canvas tag.</canvas>

<script type="text/javascript">
    var canvas = document.getElementById('myCanvas');
    var ctx = canvas.getContext('2d');
    ctx.fillStyle = '#FF0000';
    ctx.fillRect(0, 0, 80, 100);

    $(document).ready(function () {
        console.log('dff');
        $('#myCanvas').draggable();
    });
</script>
