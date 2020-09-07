CREATE FUNCTION [dbo].[fGetAllCombinationsCyrilAndLatin] 
(	
	@inpVal nvarchar(15)
)
RETURNS @tbStringComb TABLE(val nvarchar(15)) 
AS
	BEGIN
		DECLARE @cyrillicTypeLet nvarchar(30) = 'ЕТОРАНКХСВМеторанкхсвм'
		DECLARE @latinTypeLet nvarchar(30) = 'ETOPAHKXCBMetopahkxcbm'
		DECLARE @strTemp nvarchar(15)
		DECLARE @i int = 1, @j int
		DECLARE @cyrPos int, @latpos int
	    DECLARE @lenTable int
		DECLARE @tbStringTemp TABLE (
			 Id int IDENTITY(1,1) UNIQUE CLUSTERED 
			,val nvarchar(15)
		)
		
		INSERT INTO @tbStringTemp (val) VALUES (@inpVal)
				
		WHILE @i <= LEN(@inpVal)
			BEGIN
				SELECT @lenTable = COUNT(Id) FROM @tbStringTemp
				SET @j = 1
					WHILE @j <= @lenTable
						BEGIN
							SELECT TOP 1 @strTemp = val FROM @tbStringTemp WHERE Id = @j
							SET @cyrPos = CHARINDEX(SUBSTRING(@strTemp,@i,1),@cyrillicTypeLet COLLATE Cyrillic_General_CS_AS)
							SET @latpos = CHARINDEX(SUBSTRING(@strTemp,@i,1),@latinTypeLet COLLATE Latin1_General_CS_AS)
							IF(@cyrPos <> 0 OR @latpos <> 0) BEGIN
								IF @cyrPos <> 0 BEGIN
									SET @strTemp = STUFF(@strTemp,@i,1,SUBSTRING(@latinTypeLet,@cyrPos,1))
								END
								ELSE BEGIN
									SET @strTemp = STUFF(@strTemp,@i,1,SUBSTRING(@cyrillicTypeLet,@latpos,1))
								END
								INSERT INTO @tbStringTemp (val) VALUES (@strTemp)
							END
						  SET @j += 1
						END
			  SET @i += 1
			END

			INSERT INTO @tbStringComb SELECT val FROM @tbStringTemp

		RETURN
	END