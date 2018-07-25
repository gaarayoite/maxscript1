/*
 ���ܽ���
 �����òο�ͼƬ���ܵĻ��������ӵ�¼����
 ����û�֮ǰ�Ѿ���¼����ֱ�ӿ�ʼʹ��
 ��δ��¼������Ҫ���ȵ�¼
 ���ԵĲ������ΪtestPlugin1
*/
 MacroScript MiaoMiaoXue2
Tooltip:"���òο�ͼƬ"
category:"MiaoMiaoXue_Tool2"
(
	global objectLength
	global objectWidth
	global objectHeight
	function fn_findPlane thePlane = 
	(
		tp = for o in objects where matchpattern o.name pattern:thePlane collect o
		return tp
	)
	
	function fn_findAllPlanes = 
	(
		tp = for o in objects where matchpattern o.name pattern:"XX_BP_*" collect o
		return tp
	)
	
	function fn_createPlanes topPlane bottomPlane frontPlane backPlane leftPlane rightPlane =
	(
		planesArray = #(topPlane, bottomPlane, frontPlane, backPlane, leftPlane, rightPlane)
	
		--ȷ����ͼ�����еĸ�������ƽ������� �´�����ʱ��number+1
		existingTopPlanes = (fn_findPlane "XX_BP_TOP_*").count
		existingBottomPlanes = (fn_findPlane "XX_BP_BOTTOM_*").count
		existingFrontPlanes = (fn_findPlane "XX_BP_FRONT_*").count
		existingBackPlanes = (fn_findPlane "XX_BP_BACK_*").count
		existingLeftPlanes = (fn_findPlane "XX_BP_LEFT_*").count
		existingRightPlanes = (fn_findPlane "XX_BP_RIGHT_*").count
		
		for i = 1 to planesArray.count do
		(
			namePrefix = #("XX_BP_TOP_","XX_BP_BOTTOM_","XX_BP_FRONT_","XX_BP_BACK_","XX_BP_LEFT_","XX_BP_RIGHT_" )
			if planesArray[i] != "" then
			(
				imgFile = planesArray[i]
				tempMap = openBitMap imgFile
				tempMapWidth = tempMap.width
				tempMapHeight = tempMap.height
				ratio = tempMapWidth/tempMapHeight
				
				--������ֵ
				--�����߶���ֵ
				if objectLength != undefined then objectLength = objectLength as float
				if objectWidth != undefined then objectWidth = objectWidth as float
				if objectHeight != undefined then objectHeight = objectHeight as float
			
				
				--ֻ��һ��ֵ 
				
				--���� �ײ���ͼ
				--ֻ�г���
				if objectLength !=undefined and objectWidth ==undefined and objectHeight ==undefined
				    do objectWidth = objectLength * tempMapWidth/tempMapHeight
				print objectWidth
				--ֻ�п���
				if objectWidth !=undefined and objectLength == undefined and objectHeight ==undefined
					do objectLength = objectWidth*tempMapHeight/tempMapWidth
				
				--��� �Ҳ���ͼ
				--ֻ�п���
				if objectWidth !=undefined and objectHeight ==undefined and objectLength ==undefined
					do objectHeight = objectWidth * tempMapHeight/tempMapWidth
				--ֻ�и߶�
				if objectHeight !=undefined and objectWidth == undefined and objectLength ==undefined
					do objectWidth = objectHeight * tempMapWidth/tempMapHeight
				
				--ǰ ����ͼ
				--ֻ�и߶�
				if objectHeight !=undefined and objectLength == undefined and objectWidth == undefined
					do objectLength = objectHeight * tempMapWidth/tempMapHeight
				--ֻ�г���
				if objectLength !=undefined and objectHeight == undefined and objectWidth == undefined
					do objectHeight = objectLength*tempMapHeight/tempMapWidth
				
				
				--������ֵ
				--�г��� ���� ��Ҫ��������ͼ��ǰ����ͼ��ʱ��õ��߶�
				--������ͼ
				if objectLength !=undefined and objectWidth !=undefined and objectHeight == undefined and i==5 or i==6
					do objectHeight = objectWidth * tempMapHeight/tempMapWidth
				--ǰ����ͼ
				if objectLength !=undefined and objectWidth !=undefined and objectHeight == undefined and i==3 or i==4
					do objectHeight = objectLength * tempMapHeight/tempMapWidth
				
				
				--�г��� �߶�  ��Ҫ��������ͼ��������ͼ��ʱ��õ�����
				--������ͼ
				if objectLength !=undefined and objectHeight!=undefined and objectWidth == undefined and i==5 or i==6
					do objectWidth = objectHeight * tempMapWidth/tempMapHeight
				--������ͼ
				if objectLength !=undefined and objectHeight!=undefined and objectWidth == undefined and i==1 or i==2
					do objectWidth = objectLength * tempMapWidth/tempMapHeight
				
				
				--�п��� �߶� ��Ҫ��ǰ����ͼ��������ͼ��ʱ��õ�����
				--ǰ����ͼ
				if objectWidth !=undefined and objectHeight !=undefined and objectLength ==undefined and i==3 or i==4
					do objectLength = objectHeight * tempMapWidth/tempMapHeight
				--������ͼ
				if objectWidth !=undefined and objectHeight !=undefined and objectLength ==undefined and i==1 or i==2
					do objectLength = objectWidth*tempMapHeight/tempMapWidth
				
				
				print objectLength
				print objectWidth

				imgPlane = plane name:(namePrefix[i] + (getfilenameFile imgFile)) length:(objectLength) width:(objectWidth) lengthsegs:1 widthsegs:1 mapCoords:true isselected:true
				
				
				imgPlane.renderable = off
				imgPlane.showFrozenInGray = off
				imgPlane.backfacecull = on
				
				imgPlane.wirecolor = color 88 177 26				
				imgMaterial = standard()
				imgMaterial.name = imgPlane.name
				imgMaterial.selfIllumAmount = 100
				
				imgTexture = bitmaptexture()
				imgTexture.bitmap = tempMap
				
				imgMaterial.diffuseMap = imgTexture
				imgPlane.material = imgMaterial
				imgMaterial.twoSided = on
				showTextureMap imgMaterial imgMaterial.diffuseMap on
				close tempMap
				
				
				
				
				
				case of
				(
					(i == 1):  -- top plane
						(
							print "imgPlane.max:"+imgPlane.max as string
							print "imgPlane.min:"+imgPlane.min as string
							imgPlane.length = objectLength
							imgPlane.width = objectWidth
							imgPlane.rotation = (eulerangles 0 0 0)
							imgPlane.pivot = ((imgPlane.max + imgPlane.min)/2)
							imgPlane.name = imgPlane.name + (existingTopPlanes+1) as string
							imgPlane.pos = [0,0,(existingTopPlanes+1)*10]
							print "top pos:"
							print imgPlane.pos
						)
					(i == 2):  -- bottom plane
						(
							imgPlane.length = objectLength
							imgPlane.width = objectWidth
							imgPlane.rotation = (eulerangles 0 180 0)
							imgPlane.pivot = ((imgPlane.max + imgPlane.min)/2)
							imgPlane.name = imgPlane.name + (existingBottomPlanes+1) as string
							imgPlane.pos = [0,0,-(existingBottomPlanes+2)*10]
							print "bottom pos:"
							print imgPlane.pos
						)
					(i == 3):  -- front plane
						(
							imgPlane.length = objectHeight
							imgPlane.width =  objectLength
							imgPlane.rotation = (eulerangles -90 0 0)
							imgPlane.pivot = ((imgPlane.max + imgPlane.min)/2)
							imgPlane.pivot.z = imgPlane.min.z
							imgPlane.name = imgPlane.name + (existingFrontPlanes+1) as string
							imgPlane.pos = [0,(existingFrontPlanes+1)*10,0]
							print "front pos:"
							print imgPlane.pos
						)
					(i == 4):  -- back plane
						(
							imgPlane.length = objectHeight
							imgPlane.width =  objectLength
							imgPlane.rotation = (eulerangles -90 180 0)
							imgPlane.pivot = ((imgPlane.max + imgPlane.min)/2)
							imgPlane.pivot.z = imgPlane.min.z
							imgPlane.name = imgPlane.name + (existingBackPlanes+1) as string
							imgPlane.pos = [0,-(existingBackPlanes+1)*10,0]
							print "back pos:"
							print imgPlane.pos
						)
					(i == 5):  -- left plane
						(
							imgPlane.length = objectHeight
							imgPlane.width = objectWidth
							imgPlane.rotation = (eulerangles 0 90 90)
							imgPlane.pivot = ((imgPlane.max + imgPlane.min)/2)
							imgPlane.pivot.z = imgPlane.min.z
							imgPlane.name = imgPlane.name + (existingLeftPlanes+1) as string
							imgPlane.pos = [(existingLeftPlanes+1)*10,0,0]
							print "left pos:"
							print imgPlane.pos
						)
					(i == 6):  -- right plane
						(
							imgPlane.length = objectHeight
							imgPlane.width = objectWidth
							imgPlane.rotation = (eulerangles 0 -90 -90)
							imgPlane.pivot = ((imgPlane.max + imgPlane.min)/2)
							imgPlane.pivot.z = imgPlane.min.z
							imgPlane.name = imgPlane.name + (existingRightPlanes+1) as string
							imgPlane.pos = [-(existingRightPlanes+2)*10,0,0]
							print "right pos:"
							print imgPlane.pos
						)
				)
				max views redraw
			)
		)

		clearselection()
		for p in fn_findAllPlanes() do selectmore p
		
		try (fn_findPlane "XX_BP_TOP_*")[1].pos.z = selection.max.z catch()
		try (fn_findPlane "XX_BP_BOTTOM_*")[1].pos.z = selection.max.z catch()
		try (fn_findPlane "XX_BP_FRONT_*")[1].pos.y = selection.max.y catch()
		try (fn_findPlane "XX_BP_BACK_*")[1].pos.y = selection.min.y catch()
		try (fn_findPlane "XX_BP_LEFT_*")[1].pos.x = selection.max.x catch()
		try (fn_findPlane "XX_BP_RIGHT_*")[1].pos.x = selection.min.x catch()

	)	
	
	function formalFunction = (
		if blueprintManagerFloater != undefined then CloseRolloutFloater blueprintManagerFloater
         (

	
	
			rollout rlt_planeCreation "ƽ�湹��"
			(
				group "3d����ߴ�"
				(
					label lbl_objectLength "��:" align:#left  across:2
					edittext txt_objectLength "" width:195 offset:[-2,0] align:#right arcoss:2
					
					label lbl_objectWidth "��:" align:#left  across:2
					edittext  txt_objectWidth "" width:195 align:#right offset:[-2,0]  across:2
					
					label lbl_objectHeight "��:" align:#left  across:2
					edittext  txt_objectHeight "" width:195 align:#right offset:[-2,0]  across:2
					
					on txt_objectLength entered txt do(
						objectLength = txt
						txt_objectLength.text = txt
					)
					on txt_objectWidth entered txt do (
						objectWidth = txt
						txt_objectWidth.text = txt
					)
					on txt_objectHeight entered txt do (
						objectHeight = txt
						txt_objectHeight.text = txt
					)
				)
				
				group "ԴͼƬ"
				(
					label lbl_imgTop "����ͼ: " align:#left
					edittext txt_imgTop "" width:195 align:#left offset:[-2,0] across:2
					button btn_browseTop "���" width:60 align:#right offset:[0,-2]

					label lbl_imgBottom "����ͼ: " align:#left
					edittext txt_imgBottom "" width:195 align:#left offset:[-2,0] across:2
					button btn_browseBottom "���" width:60 align:#right offset:[0,-2]
					
					label lbl_imgFront "ǰ��ͼ: " align:#left
					edittext txt_imgFront "" width:195 align:#left offset:[-2,0] across:2
					button btn_browseFront "���" width:60 align:#right offset:[0,-2]

					label lbl_imgBack "����ͼ: " align:#left
					edittext txt_imgBack "" width:195 align:#left offset:[-2,0] across:2
					button btn_browseBack "���" width:60 align:#right offset:[0,-2]
					
					label lbl_imgLeft "����ͼ: " align:#left
					edittext txt_imgLeft "" width:195 align:#left offset:[-2,0] across:2
					button btn_browseLeft "���" width:60 align:#right offset:[0,-2]
					
					label lbl_imgRight "����ͼ: " align:#left
					edittext txt_imgRight "" width:195 align:#left offset:[-2,0] across:2
					button btn_browseright "���" width:60 align:#right offset:[0,-2]
				)

				button btn_createPlanes "����ƽ��" width:278 height:40
				
				on btn_browseTop pressed do
				(
					theFile = getOpenFileName()
					if theFile != undefined do txt_imgTop.text = theFile
				)
				
				on btn_browseBottom pressed do
				(
					theFile = getOpenFileName()
					if theFile != undefined do txt_imgBottom.text = theFile
				)

				on btn_browseFront pressed do
				(
					theFile = getOpenFileName()
					if theFile != undefined do txt_imgFront.text = theFile
				)
				
				on btn_browseBack pressed do
				(
					theFile = getOpenFileName()
					if theFile != undefined do txt_imgBack.text = theFile
				)
				
				on btn_browseLeft pressed do
				(
					theFile = getOpenFileName()
					if theFile != undefined do txt_imgLeft.text = theFile
				)
				
				on btn_browseRight pressed do
				(
					theFile = getOpenFileName()
					if theFile != undefined do txt_imgRight.text = theFile
				)
				
				on btn_createPlanes pressed do
				(
					if objectLength ==undefined and objectWidth ==undefined and objectHeight==undefined
						do (messagebox "���������볤�ȡ����ȡ��߶��е�һ��";
						   return())
					--existingPlanes = fn_findAllPlanes()
					--if existingPlanes.count == 0 then
					--(
						fn_createPlanes txt_imgTop.text txt_imgBottom.text txt_imgFront.text txt_imgBack.text txt_imgLeft.text txt_imgRight.text
						
						txt_imgTop.text = ""
						txt_imgBottom.text = ""
						txt_imgFront.text = ""
						txt_imgBack.text = ""
						txt_imgLeft.text = ""
						txt_imgRight.text = ""
						txt_objectLength.text = ""
						txt_objectWidth.text = ""
						txt_objectHeight.text = ""
						
						objectLength = undefined
						objectWidth = undefined
						objectHeight = undefined
					
						clearSelection()
					--)
					--else messagebox "The scene already contains a set of Blueprints.\nPlease delete or rename them before trying to create a new set."
				)
			)

			
			
			
			blueprintManagerFloater = newRolloutFloater "Blueprint Manager" 300 450
			addRollout rlt_planeCreation blueprintManagerFloater rolledUp:false
		 )
		
	)
		
	-----------------------------�ָ��� -------------------------------------	
	--�ɴ˿�ʼΪ��֤��¼����
	--�������
	pluginName = "testPlugin1"
	outstring=copy pluginName
	nc = outstring.count
	nc1  = nc+1
	fileCreateDate = ""


	try (
		fn_needLogin()
		)
	catch ()


	--���ú���createDialog ��Ϊ���ڵ�¼�ɹ�ʱ�رյ�ǰ��¼����	
	fn makeDialog =
	(
	  rollout floater "��¼��Ϣ"
	  (
		  label lbl_username "�û���:" align:#left  across:2
		edittext txt_username "" width:100 height:20  align:#right arcoss:2
				
		label lbl_password "����:" align:#left  across:2
		edittext  txt_password "" width:100 align:#right  across:2 
		
		button btn_loginBottom "��¼" width:60 align:#center
		global objectUsername = ""
		global objectPassword = ""

		on txt_username entered txt do(
					objectUsername = txt
					txt_username.text = txt
				)
				on txt_password entered txt do (
					objectPassword = txt
					txt_password.text = txt
				)
			on btn_loginBottom pressed do
			(
			   --��֤��¼��Ϣ�Ƿ���ȷ
				result = fn_validateUser objectUsername objectPassword
				--����½�ɹ��򵯳�����������ܽ���رյ�ǰ��¼���� ����������Ե�¼
				if result =="success" then (formalFunction() DestroyDialog floater) else (print "fail")
			)
	  )
	  createdialog floater width:200 height:100
	  setFocus floater.txt_username
	)


	--�ж��û��Ƿ���Ҫ���µ�¼ϵͳ	��������Ϊ����
	function fn_needLogin = (
		--�õ���ǰ������
		today= getLocalTime()
		year = today[1] as float
		month = today[2] as float
		day = today[4] as float
		--�Ƿ����pluginName.plu -���ڵĻ��õ�pluginName.plu�Ĵ������� �����ڵ�����¼����
		plugins = getFiles ((getDir #maxRoot)+"*.plu")
		--�������е�.plu�ļ� ������ڸ���ǰ�Ĳ������һ���Ĳ����õ����Ĵ������� ��������Ϊ�ļ������8λ ��������ڵ�����¼����
		--maxscript��һ���Դ���getFileCreateDate �Ƚϵ�������ڴ�����һ���ļ���1.5Сʱ�ڲ��ܷ��� ��֪��Ϊʲô
		for f in plugins do
		 (
				file = filenameFromPath   f
				fileName = substring file 1 nc
				if fileName == pluginName do (
					fileCreateDate = substring file nc1 8
					exit
					)
			
		)
		if fileCreateDate !=""
			then (
				oldYear = substring fileCreateDate 1 4
				oldMonth = substring fileCreateDate 5 2
				oldDay = substring fileCreateDate 7 2
				)
		else  (
			makeDialog()
			return false
			)
	  
		
		--createDate = "3/12/2018 1:20:45 AM"
		--�õ��������ڵ�������

		oldMonth = oldMonth as float
		oldDay = oldDay as float
		oldYear = oldYear as float
		--�ж� ����������ڸ���ǰ�������3���¼�������Ҫ���µ�¼ϵͳ		
		if (year - oldYear)>0 
				do (
					messagebox "���ĵ�¼��Ϣ�ѹ��ڣ������µ�¼";
					makeDialog()
					return false
					   )
		if(year == oldYear and (month-oldMonth)>3)
						   do (
						messagebox "���ĵ�¼��Ϣ�ѹ��ڣ������µ�¼";
						makeDialog()
						return false
						   )
		if(year == oldYear and month-oldMonth==3 and day>=oldDay)
							 do (
						messagebox "���ĵ�¼��Ϣ�ѹ��ڣ������µ�¼";
						makeDialog()
						return false
						   )
		--��������������ܽ���
		formalFunction()
		
		)
		
		
	--�ж��û��������Ƿ�������ݿ���
	function fn_validateUser username password= (
		
		if username=="" or password=="" then 
			messagebox "�������û�����������ٵ�¼"
		else  (
			TestConn=createOLEObject "ADODB.Connection"
			TestConn.Open "driver={MySQL ODBC 3.51 Driver}; server=42.62.8.123; database=assessonline;user=ducool;password=de87ao48c66a051c"
			recordSet = createOLEObject "ADODB.Recordset"
			selectString = "SELECT * from tbook_maxusers where username='"+username+"' and password='"+password+"'"
			recordSet.Open selectString TestConn -- Standard SQL Request in ""
			
			--�����ݿ��д��ڵ�ǰ������û������� �򴴽����
			try (
				recordset.GetRows()
				currentDate = (dotNetClass "System.DateTime").Now.ToString("yyyyMMdd")
				filePath = (getDir #maxRoot)+pluginName+currentDate+".plu"
				createFile filePath
				result = "success"
				return result
				)
			catch (
				messagebox "�û������벻��ȷ����¼ʧ��"
				result = "fail"
				return result
				)
			)
		
		)


)