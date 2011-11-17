//
// DotNetNuke® - http://www.dotnetnuke.com
// Copyright (c) 2002-2008
// by DotNetNuke Corporation
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated 
// documentation files (the "Software"), to deal in the Software without restriction, including without limitation 
// the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and 
// to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all copies or substantial portions 
// of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED 
// TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL 
// THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF 
// CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
// DEALINGS IN THE SOFTWARE.
//
// Events module 4.x
//

// shortcuts
function byid(eID){
	if (document.getElementById) 
		return document.getElementById(eID);
	else if (document.all)
		return document.all(eID);
	else
		return null;
}
function selIndex(eID){
    return byid(eID).options[byid(eID).selectedIndex].value;
}
function setselIndex(eID, v) {
    for ( var i = 0; i < byid(eID).options.length; i++ ) {
        if ( byid(eID).options[i].value == v ) {
            byid(eID).options[i].selected = true;
            return;
        }
    }
}
function IsWebSafe(obj,message){
    obj.value = trimAll(obj.value);
	var x = obj.value;
	var filter  = /^#([0369cCfF])\1([0369cCfF])\2([0369cCfF])\3$|^#[0369cCfF]{3}$|^$/;	
	if (filter.test(x)){
	    if (x.length == 4)
	        obj.value = x.replace(/^#(\w)(\w)(\w)$/,"#$1$1$2$2$3$3");
		return true;}
	else{
		alert(message);
		setTimeout(function(){obj.value = '';obj.focus();},10)
		return false;
	}
}
// Validation functions
function IsNumber(fieldid,botno,topno,message)
{
	var x = byid(fieldid).value;
	var filter  = /^[0-9]*$/;
	if (filter.test(x) && parseInt(x) >= botno && parseInt(x) <= topno)
		return true
	else{
        if (message == undefined)
            var message = "Enter a valid number";
		alert(message);
		byid(fieldid).value = botno;
		fid = byid(fieldid).id;
		setTimeout("byid(fid).focus();",1);
		setTimeout("byid(fid).select();",1);
		return false
	}
}
function trimAll(sString){
	while (sString.substring(0,1) == ' '){
		sString = sString.substring(1, sString.length);
	}
	while (sString.substring(sString.length-1, sString.length) == ' '){
		sString = sString.substring(0,sString.length-1);
	}
	return sString;
}

function valRemTime(remTime,remMeasurement,errorminutes,errorhours,errordays){
    if (!errorhours)
        errorhours = errorminutes;
    if (!errordays)
        errordays = errorminutes;
	switch (selIndex(remMeasurement)){
		case 'm': IsNumber(remTime,15,60,errorminutes);break;
		case 'h': IsNumber(remTime,1,24,errorhours);break;
		case 'd': IsNumber(remTime,1,30,errordays);break;
	}
}


// functions used in EditEvents
function CopyField()
{
  var SourceField
  var TargetField
  var RecEndDate
  var YearDate
  SourceField = dnn.dom.getById(CopyField.arguments[0]);
  SourceFieldId = SourceField.id;
  TargetField = dnn.dom.getById(CopyField.arguments[1]);
  RecEndDate = dnn.dom.getById(CopyField.arguments[2]);
  YearDate = dnn.dom.getById(CopyField.arguments[3]);
  if (!isNaN(Date.parse(SourceField.value))){
    if (Date.parse(SourceField.value) > Date.parse(TargetField.value))
        TargetField.value = SourceField.value;
  }
  else
      TargetField.value = SourceField.value;
}
function SetComboIndex()
{
  var SourceField;
  var TargetField;
  var SourceDate;
  var TargetDate;
  var SourceIndex;
  var TargetIndex;
  var IndexLength;
  SourceField = dnn.dom.getById(SetComboIndex.arguments[0]);
  TargetField = dnn.dom.getById(SetComboIndex.arguments[1]);
  SourceDate = dnn.dom.getById(SetComboIndex.arguments[2]);
  TargetDate = dnn.dom.getById(SetComboIndex.arguments[3]);
  SourceIndex = SourceField.options.selectedIndex;
  TargetIndex = TargetField.options.selectedIndex;
  IndexLength = SourceField.options.length - 1;
  
  if (SourceIndex >= TargetIndex && SourceIndex < IndexLength && TargetIndex != 0 && TargetDate.value == SourceDate.value)
        TargetField.options.selectedIndex = SourceField.options.selectedIndex + 1;
  else if (SourceField.options.selectedIndex == SourceField.options.length - 1)
        TargetField.options.selectedIndex = 0;
  }

function showTbl(chkField,tblDetail){
    if (dnn.dom.getById(chkField).checked == true)
        dnn.dom.getById(tblDetail).style.display = 'block';
    else
        dnn.dom.getById(tblDetail).style.display = 'none';
}
function showhideTbls(chkField1,tblDetail1,chkField2,tblDetail2,chkField3,tblDetail3,chkField4,tblDetail4,chkField5,tblDetail5){
    showTbl(chkField1, tblDetail1);
    showTbl(chkField2, tblDetail2);
    showTbl(chkField3, tblDetail3);
    showTbl(chkField4, tblDetail4);
    showTbl(chkField5, tblDetail5);
}

function showTimes(chkField,cmbField1,cmbField2){
    if (dnn.dom.getById(chkField).checked == true) {
        dnn.dom.getById(cmbField1).style.display = 'none';
        dnn.dom.getById(cmbField2).style.display = 'none';
        }
    else {
        dnn.dom.getById(cmbField1).style.display = 'inline';
        dnn.dom.getById(cmbField2).style.display = 'inline';
        }
}

function disableactivate(defaultview,ctlMonth,ctlWeek,ctlList){

    byid(ctlMonth).disabled = false;
    byid(ctlWeek).disabled = false;
    byid(ctlList).disabled = false;
    
    switch (selIndex(defaultview)){
        case 'EventMonth.ascx':
            byid(ctlMonth).disabled = true;
            byid(ctlMonth).checked = true;
            break;
        case 'EventWeek.ascx':
            byid(ctlWeek).disabled = true;
            byid(ctlWeek).checked = true;
            break;
        case 'EventList.ascx':
            byid(ctlList).disabled = true;
            byid(ctlList).checked = true;
            break;
    }
}                                
function disableCheckbox(sourceID, state, destID){          
    if (byid(sourceID).checked == state){
        byid(destID).disabled = true;
        byid(destID).checked = false;}
    else
        byid(destID).disabled = false;
}

//Copy the content of the startdate control to the enddate control
function CopyStartDateToEnddate(startdate, enddate,starttime,endtime,chkField) {
    dnn.dom.getById(enddate).value = dnn.dom.getById(startdate).value;
    if (dnn.dom.getById(chkField).checked != true) {
        dnn.dom.getById(endtime).value = dnn.dom.getById(starttime).value;
    }
}

//Limit characters to be entered in a field with a message
function limitText(limitField, limitNum, message) {
	if (limitField.value.length > limitNum) {
		limitField.value = limitField.value.substring(0, limitNum);
		alert(message + " " + limitNum);
	} 
}