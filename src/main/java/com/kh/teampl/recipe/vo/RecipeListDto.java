package com.kh.teampl.recipe.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data

public class RecipeListDto {
	private int mno;
	private String mname;
	private String mdesc;	
	private String mfilename;
	private String categories; 
}
