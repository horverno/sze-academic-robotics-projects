<?xml version='1.0' encoding='UTF-8'?>
<Project Type="Project" LVVersion="12008004">
	<Item Name="My Computer" Type="My Computer">
		<Property Name="server.app.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="server.control.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="server.tcp.enabled" Type="Bool">false</Property>
		<Property Name="server.tcp.port" Type="Int">0</Property>
		<Property Name="server.tcp.serviceName" Type="Str">My Computer/VI Server</Property>
		<Property Name="server.tcp.serviceName.default" Type="Str">My Computer/VI Server</Property>
		<Property Name="server.vi.callsEnabled" Type="Bool">true</Property>
		<Property Name="server.vi.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="specify.custom.address" Type="Bool">false</Property>
		<Item Name="dependencies" Type="Folder">
			<Item Name="Newtonsoft.Json.dll" Type="Document" URL="../Newtonsoft.Json.dll"/>
			<Item Name="Newtonsoft.Json.pdb" Type="Document" URL="../Newtonsoft.Json.pdb"/>
			<Item Name="Newtonsoft.Json.xml" Type="Document" URL="../Newtonsoft.Json.xml"/>
			<Item Name="RegistersADXL345.ctl" Type="VI" URL="../../../pelda_arduino/RegistersADXL345.ctl"/>
			<Item Name="RegistersHMC5883L-FDS.ctl" Type="VI" URL="../../../pelda_arduino/RegistersHMC5883L-FDS.ctl"/>
			<Item Name="RosBridgeDotNet.dll" Type="Document" URL="../RosBridgeDotNet.dll"/>
			<Item Name="RosBridgeDotNet.pdb" Type="Document" URL="../RosBridgeDotNet.pdb"/>
			<Item Name="System.dll" Type="Document" URL="../System.dll"/>
		</Item>
		<Item Name="subVI" Type="Folder">
			<Item Name="cmdProba.vi" Type="VI" URL="../cmdProba.vi"/>
			<Item Name="gyro1.vi" Type="VI" URL="../../../pelda_arduino/gyro1.vi"/>
			<Item Name="neo.vi" Type="VI" URL="../neo.vi"/>
			<Item Name="neo_sebesseg.vi" Type="VI" URL="../neo_sebesseg.vi"/>
			<Item Name="neo_tmp.vi" Type="VI" URL="../neo_tmp.vi"/>
			<Item Name="proba.vi" Type="VI" URL="../proba.vi"/>
			<Item Name="proba_kor_xy.vi" Type="VI" URL="../proba_kor_xy.vi"/>
			<Item Name="proba_neo_kinect.vi" Type="VI" URL="../proba_neo_kinect.vi"/>
			<Item Name="proba_szogfugv.vi" Type="VI" URL="../proba_szogfugv.vi"/>
			<Item Name="proba_ui_kor_draw.vi" Type="VI" URL="../proba_ui_kor_draw.vi"/>
			<Item Name="range.vi" Type="VI" URL="../range.vi"/>
			<Item Name="sub_sebessegszamlalo.vi" Type="VI" URL="../sub_sebessegszamlalo.vi"/>
			<Item Name="sub_szogf.vi" Type="VI" URL="../sub_szogf.vi"/>
		</Item>
		<Item Name="robotFollowsHuman.vi" Type="VI" URL="../robotFollowsHuman.vi"/>
		<Item Name="Dependencies" Type="Dependencies">
			<Item Name="vi.lib" Type="Folder">
				<Item Name="3D Comet Datatype.lvclass" Type="LVClass" URL="/&lt;vilib&gt;/Math Plots/3D Math Plots/3D Comet/3D Comet Datatype/3D Comet Datatype.lvclass"/>
				<Item Name="3D Comet.lvclass" Type="LVClass" URL="/&lt;vilib&gt;/Math Plots/3D Math Plots/3D Comet/3D Comet/3D Comet.lvclass"/>
				<Item Name="3D Comet.xctl" Type="XControl" URL="/&lt;vilib&gt;/Math Plots/3D Math Plots/3D Comet/3D Comet XCtrl/3D Comet.xctl"/>
				<Item Name="3D Plot Datatype.lvclass" Type="LVClass" URL="/&lt;vilib&gt;/Math Plots/3D Math Plots/3D Plot/3D Plot Datatype/3D Plot Datatype.lvclass"/>
				<Item Name="3D Plot.lvclass" Type="LVClass" URL="/&lt;vilib&gt;/Math Plots/3D Math Plots/3D Plot/3D Plot/3D Plot.lvclass"/>
				<Item Name="3DMathPlot Ctrl Act Cluster.ctl" Type="VI" URL="/&lt;vilib&gt;/Math Plots/3D Math Plots/3D Plot/Action String/3DMathPlot Ctrl Act Cluster.ctl"/>
				<Item Name="3DMathPlot Ctrl Act Queue.ctl" Type="VI" URL="/&lt;vilib&gt;/Math Plots/3D Math Plots/3D Plot/Action String/3DMathPlot Ctrl Act Queue.ctl"/>
				<Item Name="3DMathPlot State Class.ctl" Type="VI" URL="/&lt;vilib&gt;/Math Plots/3D Math Plots/3D Plot/Action String/3DMathPlot State Class.ctl"/>
				<Item Name="Check if File or Folder Exists.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/libraryn.llb/Check if File or Folder Exists.vi"/>
				<Item Name="Clear Errors.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Clear Errors.vi"/>
				<Item Name="Close-Depth and Skeleton.vi" Type="VI" URL="/&lt;vilib&gt;/University of Leeds/Kinesthesia Toolkit for Microsoft Kinect/_Polymorphic Close/Close-Depth and Skeleton.vi"/>
				<Item Name="Close-Depth and Video.vi" Type="VI" URL="/&lt;vilib&gt;/University of Leeds/Kinesthesia Toolkit for Microsoft Kinect/_Polymorphic Close/Close-Depth and Video.vi"/>
				<Item Name="Close-Depth, Skeleton and Video.vi" Type="VI" URL="/&lt;vilib&gt;/University of Leeds/Kinesthesia Toolkit for Microsoft Kinect/_Polymorphic Close/Close-Depth, Skeleton and Video.vi"/>
				<Item Name="Close-Depth.vi" Type="VI" URL="/&lt;vilib&gt;/University of Leeds/Kinesthesia Toolkit for Microsoft Kinect/_Polymorphic Close/Close-Depth.vi"/>
				<Item Name="Close-Skeleton and Video.vi" Type="VI" URL="/&lt;vilib&gt;/University of Leeds/Kinesthesia Toolkit for Microsoft Kinect/_Polymorphic Close/Close-Skeleton and Video.vi"/>
				<Item Name="Close-Skeleton.vi" Type="VI" URL="/&lt;vilib&gt;/University of Leeds/Kinesthesia Toolkit for Microsoft Kinect/_Polymorphic Close/Close-Skeleton.vi"/>
				<Item Name="Close-Video.vi" Type="VI" URL="/&lt;vilib&gt;/University of Leeds/Kinesthesia Toolkit for Microsoft Kinect/_Polymorphic Close/Close-Video.vi"/>
				<Item Name="Color to RGB.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/colorconv.llb/Color to RGB.vi"/>
				<Item Name="Colour Callback.vi" Type="VI" URL="/&lt;vilib&gt;/University of Leeds/Kinesthesia Toolkit for Microsoft Kinect/_Callback VIs/Colour Callback.vi"/>
				<Item Name="Configure.vi" Type="VI" URL="/&lt;vilib&gt;/University of Leeds/Kinesthesia Toolkit for Microsoft Kinect/Configure.vi"/>
				<Item Name="Depth Callback.vi" Type="VI" URL="/&lt;vilib&gt;/University of Leeds/Kinesthesia Toolkit for Microsoft Kinect/_Callback VIs/Depth Callback.vi"/>
				<Item Name="Display Colour Data (U32 to picture).vi" Type="VI" URL="/&lt;vilib&gt;/University of Leeds/Kinesthesia Toolkit for Microsoft Kinect/Additional VIs/Display Colour Data (U32 to picture).vi"/>
				<Item Name="Draw Flattened Pixmap.vi" Type="VI" URL="/&lt;vilib&gt;/picture/picture.llb/Draw Flattened Pixmap.vi"/>
				<Item Name="Draw Oval.vi" Type="VI" URL="/&lt;vilib&gt;/picture/picture.llb/Draw Oval.vi"/>
				<Item Name="Draw Point.vi" Type="VI" URL="/&lt;vilib&gt;/picture/picture.llb/Draw Point.vi"/>
				<Item Name="Draw Round Rect.vi" Type="VI" URL="/&lt;vilib&gt;/picture/picture.llb/Draw Round Rect.vi"/>
				<Item Name="Error Cluster From Error Code.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Error Cluster From Error Code.vi"/>
				<Item Name="Event-Depth and Skeleton.vi" Type="VI" URL="/&lt;vilib&gt;/University of Leeds/Kinesthesia Toolkit for Microsoft Kinect/_Polymorphic Configure/Event-Depth and Skeleton.vi"/>
				<Item Name="Event-Depth and Video.vi" Type="VI" URL="/&lt;vilib&gt;/University of Leeds/Kinesthesia Toolkit for Microsoft Kinect/_Polymorphic Configure/Event-Depth and Video.vi"/>
				<Item Name="Event-Depth, Skeleton and Video.vi" Type="VI" URL="/&lt;vilib&gt;/University of Leeds/Kinesthesia Toolkit for Microsoft Kinect/_Polymorphic Configure/Event-Depth, Skeleton and Video.vi"/>
				<Item Name="Event-Depth.vi" Type="VI" URL="/&lt;vilib&gt;/University of Leeds/Kinesthesia Toolkit for Microsoft Kinect/_Polymorphic Configure/Event-Depth.vi"/>
				<Item Name="Event-Skeleton and Video.vi" Type="VI" URL="/&lt;vilib&gt;/University of Leeds/Kinesthesia Toolkit for Microsoft Kinect/_Polymorphic Configure/Event-Skeleton and Video.vi"/>
				<Item Name="Event-Skeleton.vi" Type="VI" URL="/&lt;vilib&gt;/University of Leeds/Kinesthesia Toolkit for Microsoft Kinect/_Polymorphic Configure/Event-Skeleton.vi"/>
				<Item Name="Event-Video.vi" Type="VI" URL="/&lt;vilib&gt;/University of Leeds/Kinesthesia Toolkit for Microsoft Kinect/_Polymorphic Configure/Event-Video.vi"/>
				<Item Name="FGV-Stream Data.vi" Type="VI" URL="/&lt;vilib&gt;/University of Leeds/Kinesthesia Toolkit for Microsoft Kinect/_Functional Global Variables/FGV-Stream Data.vi"/>
				<Item Name="FixBadRect.vi" Type="VI" URL="/&lt;vilib&gt;/picture/pictutil.llb/FixBadRect.vi"/>
				<Item Name="Flatten Pixmap.vi" Type="VI" URL="/&lt;vilib&gt;/picture/pixmap.llb/Flatten Pixmap.vi"/>
				<Item Name="Get Text Rect.vi" Type="VI" URL="/&lt;vilib&gt;/picture/picture.llb/Get Text Rect.vi"/>
				<Item Name="imagedata.ctl" Type="VI" URL="/&lt;vilib&gt;/picture/picture.llb/imagedata.ctl"/>
				<Item Name="Initialise 3D Skeleton.vi" Type="VI" URL="/&lt;vilib&gt;/University of Leeds/Kinesthesia Toolkit for Microsoft Kinect/Additional VIs/Initialise 3D Skeleton.vi"/>
				<Item Name="Initialise.vi" Type="VI" URL="/&lt;vilib&gt;/University of Leeds/Kinesthesia Toolkit for Microsoft Kinect/Initialise.vi"/>
				<Item Name="Kinect Close.vi" Type="VI" URL="/&lt;vilib&gt;/University of Leeds/Kinesthesia Toolkit for Microsoft Kinect/Kinect Close.vi"/>
				<Item Name="LabVIEW Interface for Arduino.lvlib" Type="Library" URL="/&lt;vilib&gt;/LabVIEW Interface for Arduino/LabVIEW Interface for Arduino.lvlib"/>
				<Item Name="LV3DPointTypeDef.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/miscctls.llb/LV3DPointTypeDef.ctl"/>
				<Item Name="LVRectTypeDef.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/miscctls.llb/LVRectTypeDef.ctl"/>
				<Item Name="NI_3D Picture Control.lvlib" Type="Library" URL="/&lt;vilib&gt;/picture/3D Picture Control/NI_3D Picture Control.lvlib"/>
				<Item Name="NI_AALBase.lvlib" Type="Library" URL="/&lt;vilib&gt;/Analysis/NI_AALBase.lvlib"/>
				<Item Name="NI_AALPro.lvlib" Type="Library" URL="/&lt;vilib&gt;/Analysis/NI_AALPro.lvlib"/>
				<Item Name="NI_FileType.lvlib" Type="Library" URL="/&lt;vilib&gt;/Utility/lvfile.llb/NI_FileType.lvlib"/>
				<Item Name="NI_Math Plot Private Lib.lvlib" Type="Library" URL="/&lt;vilib&gt;/Math Plots/Plot Private Lib/NI_Math Plot Private Lib.lvlib"/>
				<Item Name="NI_PackedLibraryUtility.lvlib" Type="Library" URL="/&lt;vilib&gt;/Utility/LVLibp/NI_PackedLibraryUtility.lvlib"/>
				<Item Name="Read-Depth and Skeleton.vi" Type="VI" URL="/&lt;vilib&gt;/University of Leeds/Kinesthesia Toolkit for Microsoft Kinect/_Polymorphic Read/Read-Depth and Skeleton.vi"/>
				<Item Name="Read-Depth and Video.vi" Type="VI" URL="/&lt;vilib&gt;/University of Leeds/Kinesthesia Toolkit for Microsoft Kinect/_Polymorphic Read/Read-Depth and Video.vi"/>
				<Item Name="Read-Depth, Skeleton and Video.vi" Type="VI" URL="/&lt;vilib&gt;/University of Leeds/Kinesthesia Toolkit for Microsoft Kinect/_Polymorphic Read/Read-Depth, Skeleton and Video.vi"/>
				<Item Name="Read-Depth.vi" Type="VI" URL="/&lt;vilib&gt;/University of Leeds/Kinesthesia Toolkit for Microsoft Kinect/_Polymorphic Read/Read-Depth.vi"/>
				<Item Name="Read-Skeleton and Video.vi" Type="VI" URL="/&lt;vilib&gt;/University of Leeds/Kinesthesia Toolkit for Microsoft Kinect/_Polymorphic Read/Read-Skeleton and Video.vi"/>
				<Item Name="Read-Skeleton.vi" Type="VI" URL="/&lt;vilib&gt;/University of Leeds/Kinesthesia Toolkit for Microsoft Kinect/_Polymorphic Read/Read-Skeleton.vi"/>
				<Item Name="Read-Video.vi" Type="VI" URL="/&lt;vilib&gt;/University of Leeds/Kinesthesia Toolkit for Microsoft Kinect/_Polymorphic Read/Read-Video.vi"/>
				<Item Name="Read.vi" Type="VI" URL="/&lt;vilib&gt;/University of Leeds/Kinesthesia Toolkit for Microsoft Kinect/Read.vi"/>
				<Item Name="Render 3D Skeleton.vi" Type="VI" URL="/&lt;vilib&gt;/University of Leeds/Kinesthesia Toolkit for Microsoft Kinect/Additional VIs/Render 3D Skeleton.vi"/>
				<Item Name="RGB to Color.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/colorconv.llb/RGB to Color.vi"/>
				<Item Name="Skeleton Callback.vi" Type="VI" URL="/&lt;vilib&gt;/University of Leeds/Kinesthesia Toolkit for Microsoft Kinect/_Callback VIs/Skeleton Callback.vi"/>
				<Item Name="System Exec.vi" Type="VI" URL="/&lt;vilib&gt;/Platform/system.llb/System Exec.vi"/>
				<Item Name="VISA Configure Serial Port" Type="VI" URL="/&lt;vilib&gt;/Instr/_visa.llb/VISA Configure Serial Port"/>
				<Item Name="VISA Configure Serial Port (Instr).vi" Type="VI" URL="/&lt;vilib&gt;/Instr/_visa.llb/VISA Configure Serial Port (Instr).vi"/>
				<Item Name="VISA Configure Serial Port (Serial Instr).vi" Type="VI" URL="/&lt;vilib&gt;/Instr/_visa.llb/VISA Configure Serial Port (Serial Instr).vi"/>
			</Item>
			<Item Name="_LaunchHelp.vi" Type="VI" URL="/&lt;helpdir&gt;/_LaunchHelp.vi"/>
			<Item Name="lvanlys.dll" Type="Document" URL="/&lt;resource&gt;/lvanlys.dll"/>
			<Item Name="Microsoft.Kinect" Type="Document" URL="Microsoft.Kinect">
				<Property Name="NI.PreserveRelativePath" Type="Bool">true</Property>
			</Item>
			<Item Name="mscorlib" Type="VI" URL="mscorlib">
				<Property Name="NI.PreserveRelativePath" Type="Bool">true</Property>
			</Item>
			<Item Name="System" Type="VI" URL="System">
				<Property Name="NI.PreserveRelativePath" Type="Bool">true</Property>
			</Item>
		</Item>
		<Item Name="Build Specifications" Type="Build">
			<Item Name="robot" Type="EXE">
				<Property Name="App_copyErrors" Type="Bool">true</Property>
				<Property Name="App_INI_aliasGUID" Type="Str">{4E235910-FFAE-4F8B-B9FE-F58553DE2CBE}</Property>
				<Property Name="App_INI_GUID" Type="Str">{D6720807-DF97-4296-BFDA-88457F65A7A0}</Property>
				<Property Name="App_winsec.description" Type="Str">http://www.SZE.com</Property>
				<Property Name="Bld_buildCacheID" Type="Str">{BCAA2DEF-4C39-4912-9BB0-B3A303668D21}</Property>
				<Property Name="Bld_buildSpecName" Type="Str">robot</Property>
				<Property Name="Bld_excludeInlineSubVIs" Type="Bool">true</Property>
				<Property Name="Bld_excludeLibraryItems" Type="Bool">true</Property>
				<Property Name="Bld_excludePolymorphicVIs" Type="Bool">true</Property>
				<Property Name="Bld_localDestDir" Type="Path">../robotFollowsHumanBuild</Property>
				<Property Name="Bld_localDestDirType" Type="Str">relativeToCommon</Property>
				<Property Name="Bld_modifyLibraryFile" Type="Bool">true</Property>
				<Property Name="Bld_previewCacheID" Type="Str">{53C61058-9485-4338-8FAC-9F89B9A116FC}</Property>
				<Property Name="Destination[0].destName" Type="Str">robot.exe</Property>
				<Property Name="Destination[0].path" Type="Path">../robotFollowsHumanBuild/robot.exe</Property>
				<Property Name="Destination[0].preserveHierarchy" Type="Bool">true</Property>
				<Property Name="Destination[0].type" Type="Str">App</Property>
				<Property Name="Destination[1].destName" Type="Str">Support Directory</Property>
				<Property Name="Destination[1].path" Type="Path">../robotFollowsHumanBuild/data</Property>
				<Property Name="DestinationCount" Type="Int">2</Property>
				<Property Name="Source[0].itemID" Type="Str">{D4ABDE3D-DFCA-4703-B8E7-4587D871643E}</Property>
				<Property Name="Source[0].type" Type="Str">Container</Property>
				<Property Name="Source[1].destinationIndex" Type="Int">0</Property>
				<Property Name="Source[1].itemID" Type="Ref">/My Computer/subVI/neo_tmp.vi</Property>
				<Property Name="Source[1].type" Type="Str">VI</Property>
				<Property Name="Source[10].Container.applyInclusion" Type="Bool">true</Property>
				<Property Name="Source[10].destinationIndex" Type="Int">0</Property>
				<Property Name="Source[10].itemID" Type="Ref">/My Computer/Item[@Label='dependencies' and @Type='Folder']</Property>
				<Property Name="Source[10].sourceInclusion" Type="Str">Include</Property>
				<Property Name="Source[10].type" Type="Str">Container</Property>
				<Property Name="Source[2].destinationIndex" Type="Int">0</Property>
				<Property Name="Source[2].itemID" Type="Ref">/My Computer/Item[@Label='dependencies' and @Type='Folder']/RosBridgeDotNet.pdb</Property>
				<Property Name="Source[2].sourceInclusion" Type="Str">Include</Property>
				<Property Name="Source[3].destinationIndex" Type="Int">0</Property>
				<Property Name="Source[3].itemID" Type="Ref">/My Computer/Item[@Label='dependencies' and @Type='Folder']/RosBridgeDotNet.dll</Property>
				<Property Name="Source[3].sourceInclusion" Type="Str">Include</Property>
				<Property Name="Source[4].destinationIndex" Type="Int">0</Property>
				<Property Name="Source[4].itemID" Type="Ref">/My Computer/Item[@Label='dependencies' and @Type='Folder']/Newtonsoft.Json.pdb</Property>
				<Property Name="Source[5].destinationIndex" Type="Int">0</Property>
				<Property Name="Source[5].itemID" Type="Ref">/My Computer/Item[@Label='dependencies' and @Type='Folder']/Newtonsoft.Json.xml</Property>
				<Property Name="Source[6].destinationIndex" Type="Int">0</Property>
				<Property Name="Source[6].itemID" Type="Ref">/My Computer/Item[@Label='dependencies' and @Type='Folder']/Newtonsoft.Json.dll</Property>
				<Property Name="Source[7].destinationIndex" Type="Int">0</Property>
				<Property Name="Source[7].itemID" Type="Ref">/My Computer/Item[@Label='dependencies' and @Type='Folder']/System.dll</Property>
				<Property Name="Source[7].sourceInclusion" Type="Str">Include</Property>
				<Property Name="Source[8].destinationIndex" Type="Int">0</Property>
				<Property Name="Source[8].itemID" Type="Ref">/My Computer/robotFollowsHuman.vi</Property>
				<Property Name="Source[8].sourceInclusion" Type="Str">TopLevel</Property>
				<Property Name="Source[8].type" Type="Str">VI</Property>
				<Property Name="Source[9].Container.applyInclusion" Type="Bool">true</Property>
				<Property Name="Source[9].destinationIndex" Type="Int">0</Property>
				<Property Name="Source[9].itemID" Type="Ref">/My Computer/subVI</Property>
				<Property Name="Source[9].sourceInclusion" Type="Str">Include</Property>
				<Property Name="Source[9].type" Type="Str">Container</Property>
				<Property Name="SourceCount" Type="Int">11</Property>
				<Property Name="TgtF_companyName" Type="Str">SZE</Property>
				<Property Name="TgtF_fileDescription" Type="Str">robot</Property>
				<Property Name="TgtF_fileVersion.major" Type="Int">1</Property>
				<Property Name="TgtF_internalName" Type="Str">robot</Property>
				<Property Name="TgtF_legalCopyright" Type="Str">Copyright © 2013 SZE</Property>
				<Property Name="TgtF_productName" Type="Str">robot</Property>
				<Property Name="TgtF_targetfileGUID" Type="Str">{910DA3D6-75FA-4187-BDBA-17E5411871F8}</Property>
				<Property Name="TgtF_targetfileName" Type="Str">robot.exe</Property>
			</Item>
		</Item>
	</Item>
</Project>
