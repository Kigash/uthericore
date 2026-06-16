page 50962 "Registry Files Subform"
{
    // version TL2.0

    Caption = 'Lines';
    PageType = ListPart;
    SourceTable = "Registry Files Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("File No."; Rec."File No.")
                {
                    ApplicationArea = All;
                    LookupPageID = "Registry File List";
                    Visible = false;

                    trigger OnValidate();
                    begin
                        /*User.GET(USERID);
                        
                        //IF FilesRegistry.GET("File No.") THEN BEGIN
                          User.RESET;
                          User.GET(USERID);
                          DimensionValue.RESET;
                          DimensionValue.SETRANGE("Global Dimension No.",1);
                          DimensionValue.SETRANGE(Code,User."Global Dimension 1 Code");
                          IF DimensionValue.FIND('-') THEN BEGIN
                            Branch1:=DimensionValue.Name;
                          END;
                        
                          FilesRegistry.RESET;
                          FilesRegistry.GET("File No.");
                          DimensionValue.RESET;
                          DimensionValue.SETRANGE("Global Dimension No.",1);
                          DimensionValue.SETRANGE(Code,FilesRegistry.Location);
                          IF DimensionValue.FIND('-') THEN BEGIN
                            Branch2:=DimensionValue.Name;
                          END;
                        
                          IF Branch1<>Branch2 THEN
                            ERROR('You cannot request for a file a file in a different branch');*/
                        //END;

                    end;
                }
                field("File Number"; Rec."File Number")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        User.GET(USERID);
                        //IF FilesRegistry.GET("File No.") THEN BEGIN
                        User.RESET;
                        User.GET(USERID);
                        /*DimensionValue.RESET;
                        DimensionValue.SETRANGE("Global Dimension No.",1);
                        DimensionValue.SETRANGE(Code,User."Global Dimension 1 Code");
                        IF DimensionValue.FIND('-') THEN BEGIN
                          Branch1:=DimensionValue.Name;
                        END;*/

                        FilesRegistry.RESET;
                        FilesRegistry.SETRANGE("File Number", Rec."File Number");
                        //FilesRegistry.GET("File Number");
                        IF FilesRegistry.FINDFIRST THEN BEGIN
                            IF FilesRegistry."File Request Status" = FilesRegistry."File Request Status"::"Issued Out" THEN BEGIN
                                ERROR('The selected file %1 has already being issued out to %2', FilesRegistry."File Number", FilesRegistry."Current User");
                            END;
                            /* DimensionValue.RESET;
                             DimensionValue.SETRANGE("Global Dimension No.",1);
                             DimensionValue.SETRANGE(Code,FilesRegistry.Location);
                             IF DimensionValue.FIND('-') THEN BEGIN
                               Branch2:=DimensionValue.Name;
                             END;*/
                        END;//ERROR('%1,%2',Branch1,Branch2);
                        IF Branch1 <> Branch2 THEN BEGIN
                            User.RESET;
                            User.GET(USERID);
                            /* IF User."Registry User(Manager)"<> TRUE THEN
                             ERROR('You cannot request for a file a file in a different branch');
                             END;*/


                            volCount := 0;
                            editVolume := TRUE;
                            FileVolumes.RESET;
                            FileVolumes.SETRANGE(MemberNo, Rec."Member No.");
                            IF FileVolumes.FINDSET THEN BEGIN
                                REPEAT
                                    volCount += 1;
                                UNTIL FileVolumes.NEXT = 0;
                                IF volCount > 1 THEN BEGIN
                                    MESSAGE('The selected file %1 has %2 volumes, please select the volume you need.', Rec."File Number", volCount);
                                END;
                            END;
                        END;

                    end;
                }
                field("File Type"; Rec."File Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("File Name"; Rec."File Name")
                {
                    ApplicationArea = All;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnValidate();
                    begin
                        /*FilesRegistry.RESET;
                        FilesRegistry.SETRANGE("Member No.","Member No.");
                        IF FilesRegistry.FINDFIRST THEN BEGIN
                        
                          END;*/

                    end;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = All;
                }
                field("Payroll No."; Rec."Payroll No.")
                {
                    ApplicationArea = All;
                }
                field("Member Status"; Rec."Member Status")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Volume 2"; Rec."Volume 2")
                {
                    ApplicationArea = All;
                    Caption = 'Select Other Volumes';
                    LookupPageID = "File Volume";

                    trigger OnValidate();
                    begin
                        volCount := 0;
                        Rec.Volume := '';
                        RegistryFilesLines.RESET;
                        RegistryFilesLines.SETRANGE("Request ID", Rec."Request ID");
                        IF RegistryFilesLines.FINDFIRST THEN BEGIN
                            FileVolumes.RESET;
                            FileVolumes.SETRANGE(MemberNo, RegistryFilesLines."Member No.");
                            FileVolumes.SETRANGE(Select, TRUE);
                            IF FileVolumes.FINDSET THEN BEGIN
                                volCount := FileVolumes.COUNT;
                                IF volCount > 1 THEN BEGIN //MESSAGE('found %1',volCount);
                                    REPEAT
                                        Rec.Volume := Rec.Volume + ',' + FileVolumes.Volume;
                                        Rec."Volume 2" := '';
                                    UNTIL FileVolumes.NEXT = 0;
                                END ELSE BEGIN
                                    Rec.Volume := Rec."Volume 2";
                                END;
                            END;
                        END;
                        //MESSAGE('%1',Volume);
                    end;
                }
                field(Volume; Rec.Volume)
                {
                    Editable = editVolume;
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Location; Rec.Location)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Status2; Rec.Status2)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("HOD Approval"; Rec."HOD Approval")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("HOD Rejected"; Rec."HOD Rejected")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("HOD Comments"; Rec."HOD Comments")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Registry Approval"; Rec."Registry Approval")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Registry Rejected"; Rec."Registry Rejected")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Registry Comment"; Rec."Registry Comment")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Approve)
            {
                Caption = 'HOD Approve';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = false;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    IF Rec.Status2 <> Rec.Status2::"Pending Approval" THEN
                        ERROR('You cannot approve the request at this stage.');
                    IF CONFIRM('Are you sure you want to approve?') THEN BEGIN
                        Rec."HOD Approval" := TRUE;
                        Rec."Approved/Rejection Time" := CURRENTDATETIME;
                        //MESSAGE('Kindly Fill in your Approval Comment.');
                        Rec."Request Status" := Rec."Request Status"::"HOD Approved";
                        MESSAGE('Approved');
                    END;
                end;
            }
            action("Reject (HOD)")
            {
                Caption = 'HOD Reject';
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = false;
                ApplicationArea = All;


                trigger OnAction();
                begin
                    IF Rec.Status2 <> Rec.Status2::"Pending Approval" THEN
                        ERROR('You cannot reject the request at this stage.');
                    IF CONFIRM('Are you sure you want to reject?') THEN BEGIN
                        Rec."HOD Rejected" := TRUE;
                        Rec."Approved/Rejection Time" := CURRENTDATETIME;
                        Rec."Request Status" := Rec."Request Status"::"HOD Rejected";
                        MESSAGE('Rejected');
                    END;
                end;
            }
            action("Approve(Registry)")
            {
                Caption = 'Registry Approve';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = false;
                ApplicationArea = All;


                trigger OnAction();
                begin
                    IF Rec.Status2 <> Rec.Status2::Active THEN
                        ERROR('You cannot approve the request at this stage.');
                    IF CONFIRM('Are you sure you want to approve?') THEN BEGIN
                        Rec."Registry Approval" := TRUE;
                        Rec."Approved/Rejection Time" := CURRENTDATETIME;
                        Rec."Request Status" := Rec."Request Status"::"Registry Approved";
                        MESSAGE('Approved');
                    END;
                end;
            }
            action("Reject(Registry)")
            {
                Caption = 'Registry Reject';
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = false;
                ApplicationArea = All;


                trigger OnAction();
                begin
                    IF Rec.Status2 <> Rec.Status2::Active THEN
                        ERROR('You cannot reject the request at this stage.');
                    IF CONFIRM('Are you sure you want to reject?') THEN BEGIN
                        Rec."Registry Rejected" := TRUE;
                        Rec."Approved/Rejection Time" := CURRENTDATETIME;
                        Rec."Request Status" := Rec."Request Status"::"Registry Rejected";
                        MESSAGE('Rejected');
                    END;
                end;
            }
        }
    }

    trigger OnOpenPage();
    begin
        User.GET(USERID);
        editVolume := FALSE;
        seeMultiple := FALSE;
    end;

    var
        FilesRegistry: Record "Registry File";
        UserRequestCount: Integer;
        UserRec: Record "Registry Files Line";
        HODApproval: Boolean;
        RegistryApproval: Boolean;
        User: Record "User Setup";
        FileIssuance: Record "File Issuance";
        EditLines: Boolean;
        //DimensionValue : Record "349";
        Branch1: Text;
        Branch2: Text;
        FileVolumes: Record "File Volume";
        volCount: Integer;
        editVolume: Boolean;
        RegistryFilesLines: Record "Registry Files Line";
        seeMultiple: Boolean;
}

