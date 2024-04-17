<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!doctype html>
<html lang="utf-8">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>addRecipe.jsp</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    
    <style>
       
   	/* navbar */
   	#inputSearch {
   		width : 200px;
   	}
   	
   	#divNav {
   		display:flex;
   		flex-direction:row;
   		justify-content: space-between;
   	}
   	
   	nav {
   		height: 10vh;
   		margin: auto 10px;
   	}
   	
   	/* title */
   	#title {
   		height:10vh;
   	}
   	
   	/* category */
   	#divSearch {
   		display:flex;
   		flex-direction:column;
   		align-items:center;
   	}
   	
   	#divSearch * {
   		margin: 5px auto;
   	}
   	
   	/* addRecipeForm */
   	#addRecipeFormWrapper {
		/* height: 100vh; */
		width: 100%;
		/* background-color: black; */
		background-image: images/addRecipeBackground.jpg;
		display: flex;
		flex-direction:row;
		justify-content: center;
		align-items: center;	
	}
 		
	#addRecipeForm {
		border:solid 2px;
		border-radius:20px;
		padding:30px;
		background-color:white;
		width:80vh;
		margin-top:100px;
		margin-bottom:100px;
	}
	
	/* ingredients */
	
	#ingredients {
		margin-bottom:10px;
	}
	
	.inputIngredients {
		margin-top:10px;
		margin-bottom:10px;
	}
	
	.recipe {
		display:flex;
		
	}
	
	/* pictures */
	
	#pictureDiv {
		display:flex;
		flex-direction:column;
		width:200px;
	}
	
	#pictureDiv button {
		margin-top:5px;
		width:99px;
	}
	
	#uploadDiv {
		width: 80%;
		height: 100px;
		margin: 20px auto;
		border: 1px dashed;
		background-color:#DEDEDE;
	}
	
	#uploadedDiv {
		display:flex;
		justify-content:space-between;
		margin-top:40px;
		maring-left:40px;
		maring-right:40px;
	}
	
	#uploadedDivatModal {
		display:flex;
		justify-content:space-around;
		margin-top:20px;
		maring-left:20px;
		maring-right:20px;
	}
	
	.uploadedItem {
		display:flex;
		flex-direction:column;
		align-item:center;
		justify-content:center;
	}
	
	.uploadedItem:hover {
		cursor:pointer;
	}
	
	.uploadedItem:visited {
		border:solid 2px;
		border-radius:20px;
	}
	
	/* submitDiv */
	#submitDiv {
		display:flex;
		justify-content:center;
	}	
	
	
	
    </style>
  </head>
  <script src="/js/utilscript.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
  <script>
  	$(function() {
  		
  		$("#none").click(function() {
  			
  		});
  		
  		function makeArrayFromNames(namevalue) {
  		 	//값들의 갯수 -> 배열 길이를 지정
  		 	var element = "input[name=";
  		 	element += namevalue;
  		 	element += "]";
  		 	
  		 	console.log(element);
  		 	
  		  	var grpl = $(element).length;
  		  	console.log("배열의 길이 "  + grpl);
  		  	
  		  	//배열 생성
  		  	var grparr = new Array(grpl);
  		  			
  		  	//배열에 값 주입
  		  	for(var i=0; i<grpl; i++){                          
  		  		grparr[i] = $(element).eq(i).val();
  		  	}
  		  	
  		  	return grparr; 
  		 }
  		
  		// 1번 2번 : default로 주어져 있음. 
  		var orderIndex = 3;
  		
  		// 재료 추가
  		$("#btnIngredientsPlus").click(function() {
  			console.log("btn ing");
  			
  			var ingInput = $("#ingredients-original").clone();
  			// ingInput.replaceChild(orderIndex, $("#index"));
  			ingInput.removeAttr("id");
			ingInput.addClass("inputIngredients");
			ingInput.show();
  			$("#InginputDiv").append(ingInput);
  			
  		});
  		
  		// 재료 감소 
  		$("#btnIngredientsSub").click(function() {
  			$(".inputIngredients").eq(-1).remove();
  		});
  		
  		// 순서 추가 기입 
  		$("#btnRecipePlus").click(function() {			
	  		var orderInput = $("#recipe-original").clone();
	  		orderInput.removeAttr("id");
	  		orderInput.addClass("inputRecipe");
	  		orderInput.show();
  			$("#recipeInputDiv").append(orderInput);
  			
  			orderIndex++;
  		});
  		
  		$("#btnRecipeSub").click(function() {
  			$(".inputRecipe").eq(-1).remove();
  		});
  		
  		// 사진 업로드 
  		$("#uploadDiv").on("dragenter dragover", function(e) {
  			e.preventDefault();
  		});
  		
  		$("#uploadDiv").on("drop", function(e) {
  			e.preventDefault();
  			console.log(e);
  			
  			var file = e.originalEvent.dataTransfer.files[0];
  			console.log(file);
  			
  			var formData = new FormData(); // HTML5
  			formData.append("file", file);
  			formData.append("type", "recipe");
  			url = "/upload/uploadFile";
  			
  			$.ajax({
  				"type" : "post",
  				"processData" : false, // ?a=b&c=d(x)
  				"contentType" : false, // application/x-www-form-urlencoded (x)
  				"url" : url,
  				"data" : formData,
  				"success" : function(rData) {
  					console.log(rData);
  					var div = $("#uploadedItem").clone();
  					div.removeAttr("id");
  					div.addClass("uploadedItem");
  					var filename = rData.substring(rData.indexOf("_") + 1);
  					div.find("span").text(filename);
  					
  					if (isImage(filename)) {
  						var thumbnail = getThumbnailName(rData);
  						div.find("img")
  							.attr("src", "/upload/displayImage?filePath=" + thumbnail);
  					}
  					
  					div.find("a").attr("data-filename", rData);
					// var divClone = div.clone();
					
  					$("#uploadedDiv").append(div);
  					// $("#uploadedDivatModal").append(divClone);
  					// $("#uploadedDivatModal a").remove();
  					div.fadeIn(1000);
  					// divClone.fadeIn(1000);
  					
  					//var uploadedDivs = $(".uploadedDiv");
  					//console.log(uploadedDivs);
  					
  					//div.fadeIn(1000);
  				}
  			});
  			  			
  		}); // 사진 drop & down
  		
  		// 첨부파일 삭제 링크 [x]
  		$("#uploadedDiv").on("click", "a", function(e) {
  			
  			e.preventDefault();
  			var that = $(this);
  			var filename = that.attr("data-filename");
  			var url = "/upload/deleteFile";
  			
  			$.ajax({
  				"type" : "delete",
  				"url" : url,
  				"data" : filename,
  				"dataType" : "text",
  				"success" : function(rData) {
  					console.log(rData);
  					if (rData == "SUCCESS") {
  						that.parent().remove();
  					}
  				}
  			});
  		});
  		
  		// 대표 이벤트 지정하기 :  동적(JavaScript)으로 생성된 태그들에 대한 이벤트 -> on method
  		// 1. 선택한 이미지에 대해 체크 표시 (CSS) : O 
  		// 2. form에 전송할 썸네일 파일 이름 등록 하기 
  		
  		$(document).on("click", "div[class='uploadedItem']", function() {
    		// console.log("this div is clicked");
    		$(".uploadedItem").attr("style","");
    		$(this).attr("style","border:solid 2px; border-radius:20px; padding:10px;");
    		var filename = $(this).find("a").attr("data-filename");
    		
    		$("#mfilename").text(filename);
    		console.log("mfilename : ", $("#mfilename").text());
  		});
  		
  		$("#formtest").click(function() {  			  			
  			var form = $('<form></form>');
  		    form.attr('action', "/recipe/addRecipeRun");
  		    form.attr('method', 'post');
  		    form.appendTo('body');
  			
  			/* name */
  			
  			// 1. categories
  			var rdoInputs = $("#divRadio").find("input");
  			var chkInputs = $("#divCheckbox").find("input");
  			var categories = [];
  			
  			// radio btn : H / I 
  			var tempVal = $("input[name='temp']:checked").val();
  			categories.push(tempVal);
  			// checkbox : latte, alcohol, fruit, cream
  							
  			$("input[name='categories']").each(function() {
  				if ("input[id=none]:checked") {
  					console.log("checked");
  					categories.push("N");
  	  			} else {
	  	  			if ($(this).prop("checked") == true) {
	  	  				console.log($(this));
	  					categories.push("Y");
	  				} else {
	  					categories.push("N");
	  				}
  	  			}
  					
  			});
  			
  			form.append($('<input type="hidden" value="' + categories + '" name=categories>'));
  			
  			// 2. recipeTitle 
  			form.append($('<input type="hidden" value="' + $("#recipeTitle").val() + '" name=recipeTitle>'));
  				
  			// 3. recipeComment 
  			form.append($('<input type="hidden" value="' + $("#recipeComment").val() + '" name=recipeComment>'));
  			
  			// 4. ingredients
  			form.append($('<input type="hidden" value="' + makeArrayFromNames("ingredients") + '" name=ingredients>'));
  			
  			// 5. recipe
  			form.append($('<input type="hidden" value="' + makeArrayFromNames("recipe") + '" name=recipe>'));
  			
  			// 6. filenames
  			var filenames = [];
  			
  			$("#uploadedDiv a").each(function() {
  				var filename = $(this).attr("data-filename");
  				filenames.push(filename);
  			});
  			
  			form.append($('<input type="hidden" value="' + filenames + '" name=filenames>'));
  			
  			// 7. mfilename 
  			form.append($('<input type="hidden" value="' + $("#mfilename").text() + '" name=mfilename>'));
  			
  			
  			// 등록 전 체크 -> 
  			
  			// console.log(form);
			// form.submit();  	
			console.log("mfilename : ");
			console.log($("input[name=mfilename]").val());
			console.log(form);
  		});
  	});
  </script>
  <body>
  
  	<%@ include file="/WEB-INF/views/include/nav.jsp" %>
	
	<!-- addRecipeForm -->
	<div id="addRecipeFormWrapper" style="background-image: images/addRecipeBackground.jpg;">
		<div id="addRecipeForm">
			<form action="/recipe/addRecipe" method="post">
				<div class="mb-3">
					<div class="alert alert-warning" role="alert">
  						모든 등록 양식을 빠짐없이 기입해주세요.
					</div>	
					<label for="recipeTitle" class="form-label">카테고리</label> 
					<!-- searchDiv -->
					<div class="container-fluid">
						<div id="divCategory" class="row">
							<div class="col-md-12">
								<div id="divSearch" class="jumbotron">
									<!-- div : radio box -->
									<div id="divRadio" class="btn-group" role="group"
										aria-label="Basic radio toggle button group">
										<input type="radio" class="btn-check" name="temp" value="H"
											   id="btnradio1" autocomplete="off" checked> 
										<label class="btn btn-outline-primary" for="btnradio1">Hot</label> 
										<input type="radio" class="btn-check" name="temp" value="I"
											   id="btnradio2" autocomplete="off"> 
										<label class="btn btn-outline-primary" for="btnradio2">Ice</label>
									</div>
		
									<!-- div : check box -->
									<div id="divCheckbox" class="btn-group" role="group"
										aria-label="Basic checkbox toggle button group">
										
										<input type="checkbox" class="btn-check" id="none"
											   autocomplete="off" name="none" value="none"> 
										<label class="btn btn-outline-primary" for="none">없음</label>
										
										<input type="checkbox" class="btn-check" id="isLatte"
											   autocomplete="off" name="categories" value="latte"> 
										<label class="btn btn-outline-primary" for="isLatte">라떼</label>
										 
										<input type="checkbox" class="btn-check" id="isSyrub"
											   autocomplete="off" name="categories" value="syrub"> 
										<label class="btn btn-outline-primary" for="isSyrub">시럽</label>
										 
										<input type="checkbox" class="btn-check" id="isALcohol"
											   autocomplete="off" name="categories" value="alcohol"> 
										<label class="btn btn-outline-primary" for="isALcohol">알코올</label>
										 
										<input type="checkbox" class="btn-check" id="isFruit"
											   autocomplete="off" name="categories" value="fruit"> 
										<label class="btn btn-outline-primary" for="isFruit">과일</label>
										 
										<input type="checkbox" class="btn-check" id="isCream"
											   autocomplete="off" name="categories" value="cream"> 
										<label class="btn btn-outline-primary" for="isCream">크림</label> 
									</div>
								</div>
							</div>
						</div>
					</div>				
				</div> <!-- /searchDiv -->	
			
				<div class="mb-3">
					<label for="recipeTitle" class="form-label">레시피 이름</label> 
					<input type="text" class="form-control" id="recipeTitle" name="recipeTitle">									
				</div>
   
   				<hr>
   				
   				<div class="mb-3">
					<label for="recipeComment" class="form-label">한 줄 평가</label> 
					<input type="text" class="form-control" id="recipeComment" name="recipeComment">									
				</div>
				
				<hr>
   				
				<!-- '재료 추가' 버튼으로 해당 div 내 input clone하는 방향으로 재료 늘려나감 -->
				<div id="ingredients">
					
					<div class="mb-3 add-ingredient">
						<label for="recipeTitle" class="form-label">재료</label>
						<div id="ingredientsHelp" class="form-text">모든 재료 양은 1인분을 기준으로 합니다.</div>
						<div id="ingredientsHelp" class="form-text">(빈칸이 없도록)</div> 
						<input type="text" class="form-control ingredients" 
						       aria-describedby="ingredientsHelp" name="ingredients">
					</div>
					
					<div id="InginputDiv">
					
						<div id="ingredients-original" class="mb-3 add-ingredient ingredients" style="display:none;">
							<input type="text" class="form-control ingredients"
							       aria-describedby="ingredientsHelp" name="ingredients">
							<div id="ingredientsHelp" class="form-text"></div>  									
						</div>
						
						<div class="mb-3 add-ingredient ingredients inputIngredients">
							<input type="text" class="form-control ingredients" 
							       aria-describedby="ingredientsHelp" name="ingredients">
							<div id="ingredientsHelp" class="form-text"></div>  									
						</div>
					
					</div>
					
					<div>
						<button id="btnIngredientsPlus" type="button" class="btn btn-primary">재료 +</button>
						<button id="btnIngredientsSub" type="button" class="btn btn-danger">재료 - </button>
					</div> 
										
				</div>
				
				<hr>
				
				<div id="recipe">
					<div class="mb-3 add-recipe">
						<label for="recipeTitle" class="form-label">만드는 법</label>
						<div id="recipeHelp" class="form-text">순서대로 적어주세요.</div>
						<div id="recipeHelp" class="form-text">(빈칸이 없도록)</div>
						<input type="text" class="form-control ingredients" 
						       aria-describedby="recipeHelp" name="recipe">
					</div>
					
					<div id="recipeInputDiv">
					
						<div id="recipe-original" class="mb-3 recipe" style="display:none;">
							<input type="text" class="form-control recipe"
							       aria-describedby="recipeHelp" name="recipe">
							<div id="recipeHelp" class="form-text"></div>  									
						</div>
						
						<div class="mb-3 inputRecipe">
							<input type="text" class="form-control recipe" 
							       aria-describedby="recipeHelp" name="recipe">
							<div id="recipeHelp" class="form-text"></div>  									
						</div>
						
					</div>
				</div>
				
				<div>
						<button id="btnRecipePlus" type="button" class="btn btn-primary">순서 +</button>
						<button id="btnRecipeSub" type="button" class="btn btn-danger">순서 -</button>
				</div>
								
				<hr>
				
				<div id="addPicture">
					
					<div id="pictureDiv">
						<label for="recipeTitle" class="form-label">사진</label>
						<div id="pictureHelp" class="form-text">업로드 이미지 중에서</div>
						<div id="pictureHelp" class="form-text">썸네일 사진을 클릭해주세요.</div>
						<div id="pictureHelp" class="form-text">(필수)</div>
						<button type="button" class="btn btn-success "
					        data-bs-toggle="modal" data-bs-target="#exampleModal">사진 첨부</button>
					
						<!-- Vertically centered scrollable modal -->
						<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
							<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
								<div class="modal-content">
									<div class="modal-header">
										<h5 class="modal-title">사진 첨부하기 (최대 3장) </h5>
										<button type="button" class="btn-close" data-bs-dismiss="modal"
											aria-label="Close"></button>
									</div>
									<div class="modal-body">
										<div id="uploadDiv"></div>
									</div>
																
									<div id="uploadedItem" style="display:none;">
										<img src="/images/default.png" height="50"><br>
										<span id="mfilename" style="display:none;"></span>
										<span>default</span>
										<a href="#">&times;</a>
									</div>
									
									<div id="uploadedDivatModal">
										
									</div>
	
									<div class="modal-footer">
										<button type="button" class="btn btn-primary"
											data-bs-dismiss="modal">첨부 완료</button>
									</div>
								</div> <!-- /modal-content -->
							</div> <!-- /modal-dialog -->
						</div> <!-- /modal -->
					</div>
					
					<div id="uploadedDiv">
					 
					</div>
					
				</div> <!-- /addPicture -->
				
				<hr>
				
				<div id="submitDiv">
					<button id="formtest" class="btn btn btn-primary" type="button">레시피 작성하기</button>
				</div>
				
			</form>
		</div>
	</div>
	<!-- /addRecipeForm -->
	
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
  </body>
</html>