package com.dell.utils.string
{
	/**
	 * Remove tabs from string.
	 */
	public function removeTabs(str:String):String
	{
		return replace(str, "  ", "");
	}

}