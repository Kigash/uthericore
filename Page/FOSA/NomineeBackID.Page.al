page 50049 "Nominee Back ID"
{
    Caption = 'Back ID';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = CardPart;
    SourceTable = "Beneficiary Type";

    layout
    {
        area(content)
        {
            field("Back ID"; Rec."Back ID")
            {
                ApplicationArea = All;
                ShowCaption = false;
                ToolTip = 'Specifies the Back ID of the Member, for example, a logo.';
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(TakePicture)
            {
                ApplicationArea = All;
                Caption = 'Take';
                Image = Camera;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Activate the camera on the device.';
                Visible = CameraAvailable;

                trigger OnAction()
                begin
                    TakeNewPicture;
                end;
            }
            action(ImportPicture)
            {
                ApplicationArea = All;
                Caption = 'Import';
                Image = Import;
                ToolTip = 'Import a picture file.';

                trigger OnAction()
                var
                    FileManagement: Codeunit "File Management";
                    FileName: Text;
                    ClientFileName: Text;
                begin
                    Rec.TestField("Application No.");
                    if Rec.Name = '' then
                        Error(MustSpecifyNameErr);

                    if Rec."Back ID".HasValue then
                        if not Confirm(OverridePictureQst) then
                            exit;

                    FileName := FileManagement.UploadFile(SelectPictureTxt, ClientFileName);
                    if FileName = '' then
                        exit;

                    Clear(Rec."Back ID");
                    Rec."Back ID".ImportFile(FileName, ClientFileName);
                    if not Rec.Modify(true) then
                        Rec.Insert(true);

                    if FileManagement.DeleteServerFile(FileName) then;
                end;
            }
            action(ExportFile)
            {
                ApplicationArea = All;
                Caption = 'Export';
                Enabled = DeleteExportEnabled;
                Image = Export;
                ToolTip = 'Export the picture to a file.';

                trigger OnAction()
                var
                    DummyPictureEntity: Record "Picture Entity";
                    FileManagement: Codeunit "File Management";
                    ToFile: Text;
                    ExportPath: Text;
                begin
                    Rec.TestField("Application No.");
                    Rec.TestField("Name");

                    ToFile := DummyPictureEntity.GetDefaultMediaDescription(Rec);
                    ExportPath := TemporaryPath + Rec."Application No." + Format(Rec."Back ID".MediaId);
                    Rec."Back ID".ExportFile(ExportPath);

                    FileManagement.ExportImage(ExportPath, ToFile);
                end;
            }
            action(DeletePicture)
            {
                ApplicationArea = All;
                Caption = 'Delete';
                Enabled = DeleteExportEnabled;
                Image = Delete;
                ToolTip = 'Delete the record.';

                trigger OnAction()
                begin
                    Rec.TestField("Application No.");
                    if not Confirm(DeletePictureQst) then
                        exit;

                    Clear(Rec."Back ID");
                    Rec.Modify(true);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetEditableOnPictureActions;
    end;

    trigger OnOpenPage()
    begin
        // CameraAvailable := CameraProvider.IsAvailable;
        // if CameraAvailable then
        //     CameraProvider := CameraProvider.Create;
    end;

    var
        // [RunOnClient]
        // [WithEvents]
        // CameraProvider: DotNet CameraProvider;
        CameraAvailable: Boolean;
        OverridePictureQst: Label 'The existing picture will be replaced. Do you want to continue?';
        DeletePictureQst: Label 'Are you sure you want to delete the picture?';
        SelectPictureTxt: Label 'Select a picture to upload';
        DeleteExportEnabled: Boolean;
        MustSpecifyNameErr: Label 'You must specify a Member Full Name before you can import a "Back ID".';

    procedure TakeNewPicture()
    var
    //CameraOptions: DotNet CameraOptions;
    begin
        Rec.Find;
        Rec.TestField("Application No.");
        Rec.TestField("Name");

        if not CameraAvailable then
            exit;

        // CameraOptions := CameraOptions.CameraOptions;
        // CameraOptions.Quality := 50;
        // CameraProvider.RequestPictureAsync(CameraOptions);
    end;

    local procedure SetEditableOnPictureActions()
    begin
        DeleteExportEnabled := Rec."Back ID".HasValue;
    end;

    procedure IsCameraAvailable(): Boolean
    begin
        //exit(CameraProvider.IsAvailable);
    end;

    // trigger CameraProvider::PictureAvailable(PictureName: Text; PictureFilePath: Text)
    // var
    //     File: File;
    //     Instream: InStream;
    // begin
    //     if (PictureName = '') or (PictureFilePath = '') then
    //         exit;

    //     if "Back ID".HasValue then
    //         if not Confirm(OverridePictureQst) then begin
    //             if Erase(PictureFilePath) then;
    //             exit;
    //         end;

    //     File.Open(PictureFilePath);
    //     File.CreateInStream(Instream);

    //     Clear("Back ID");
    //     "Back ID".ImportStream(Instream, PictureName);
    //     if not Modify(true) then
    //         Insert(true);

    //     File.Close;
    //     if Erase(PictureFilePath) then;
    // end;
}

