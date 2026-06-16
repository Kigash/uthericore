page 50403 "Employee Back ID"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = CardPart;
    SourceTable = Employee;

    layout
    {
        area(content)
        {
            field("Back Side ID"; Rec."Back Side ID")
            {
                ApplicationArea = Basic, Suite;
                ShowCaption = false;
                ToolTip = 'Specifies the Back side id of the employee.';
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(TakePicture)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Take';
                Image = Camera;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Activate the camera on the device.';
                Visible = CameraAvailable;

                trigger OnAction()
                var
                //CameraOptions: DotNet CameraOptions;
                begin
                    Rec.Testfield("No.");
                    Rec.TestField("First Name");
                    Rec.Testfield("Last Name");
                    if not CameraAvailable then
                        exit;
                    // CameraOptions := CameraOptions.CameraOptions;
                    // CameraOptions.Quality := 100;
                    // CameraProvider.RequestPictureAsync(CameraOptions);
                end;
            }
            action(ImportPicture)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Import';
                Image = Import;
                ToolTip = 'Import a picture file.';

                trigger OnAction()
                var
                    FileManagement: Codeunit "File Management";
                    FileName: Text;
                    ClientFileName: Text;
                begin
                    Rec.Testfield("No.");
                    Rec.TestField("First Name");
                    Rec.Testfield("Last Name");
                    if Rec."Back Side ID".HasValue then
                        if not Confirm(OverrideImageQst) then
                            exit;

                    //FileName := FileManagement.UploadFile(SelectPictureTxt, ClientFileName);
                    if FileName = '' then
                        exit;

                    Clear(Rec."Back Side ID");
                    Rec."Back Side ID".ImportFile(FileName, ClientFileName);
                    Rec.Modify(true);

                    if FileManagement.DeleteServerFile(FileName) then;
                end;
            }
            action(ExportFile)
            {
                ApplicationArea = Basic, Suite;
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
                    Rec.Testfield("No.");
                    Rec.TestField("First Name");
                    Rec.Testfield("Last Name");
                    ToFile := DummyPictureEntity.GetDefaultMediaDescription(Rec);
                    ExportPath := TemporaryPath + Rec."No." + Format(Rec."Back Side ID".MediaId);
                    Rec."Back Side ID".ExportFile(ExportPath);

                    FileManagement.ExportImage(ExportPath, ToFile);
                end;
            }
            action(DeletePicture)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Delete';
                Enabled = DeleteExportEnabled;
                Image = Delete;
                ToolTip = 'Delete the record.';

                trigger OnAction()
                begin
                    Rec.Testfield("No.");
                    if not Confirm(DeleteImageQst) then
                        exit;

                    Clear(Rec."Back Side ID");
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
        OverrideImageQst: Label 'The existing picture will be replaced. Do you want to continue?';
        DeleteImageQst: Label 'Are you sure you want to delete the picture?';
        SelectPictureTxt: Label 'Select a picture to upload';
        DeleteExportEnabled: Boolean;

    local procedure SetEditableOnPictureActions()
    begin
        DeleteExportEnabled := Rec.Image.HasValue;
    end;

    // trigger CameraProvider::PictureAvailable(PictureName: Text; PictureFilePath: Text)
    // var
    //     File: File;
    //     Instream: InStream;
    // begin
    //     if (PictureName = '') or (PictureFilePath = '') then
    //         exit;

    //     if "Back Side ID".HasValue then
    //         if not Confirm(OverrideImageQst) then begin
    //             if Erase(PictureFilePath) then;
    //             exit;
    //         end;

    //     File.Open(PictureFilePath);
    //     File.CreateInStream(Instream);

    //     Clear("Back Side ID");
    //     "Back Side ID".ImportStream(Instream, PictureName);
    //     if not Modify(true) then
    //         Insert(true);

    //     File.Close;
    //     if Erase(PictureFilePath) then;
    // end;
}