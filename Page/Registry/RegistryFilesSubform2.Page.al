page 55716 "Registry Files Subform2"
{
    // version CBS-TL,REG

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
                    LookupPageID = "Registry File List";
                    Visible = false;
                }
                field("File Number"; Rec."File Number")
                {
                    Editable = false;
                }
                field("File Type"; Rec."File Type")
                {
                    Editable = false;
                }
                field("File Name"; Rec."File Name")
                {
                }
                field("Member No."; Rec."Member No.")
                {
                }
                field("ID No."; Rec."ID No.")
                {
                }
                field("Payroll No."; Rec."Payroll No.")
                {
                }
                field("Member Status"; Rec."Member Status")
                {
                    Editable = false;
                    Visible = false;
                }
                field(Type; Rec.Type)
                {
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    Visible = false;
                }
                field(Volume; Rec.Volume)
                {
                }
                field(Location; Rec.Location)
                {
                    Visible = false;
                }
                field(Status2; Rec.Status2)
                {
                    Visible = false;
                }
                field("Other User"; Rec."Other User")
                {
                    Visible = false;
                }
                field("HOD Approval"; Rec."HOD Approval")
                {
                    Editable = false;
                    Visible = HODApproval;
                }
                field("HOD Rejected"; Rec."HOD Rejected")
                {
                    Visible = HODApproval;
                }
                field("HOD Comments"; Rec."HOD Comments")
                {
                    Visible = false;
                }
                field("Registry Approval"; Rec."Registry Approval")
                {
                    Editable = false;
                    Visible = RegistryApproval;
                }
                field("Registry Rejected"; Rec."Registry Rejected")
                {
                    Visible = RegistryApproval;
                }
                field("Registry Comment"; Rec."Registry Comment")
                {
                    Visible = false;
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
                Visible = HODApproval;

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
                Visible = HODApproval;

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

        IF User."User ID" <> '' THEN BEGIN
            HODApproval := TRUE;
        END;

        IF User."User ID" <> '' THEN BEGIN
            RegistryApproval := TRUE;
        END;
    end;

    var
        FilesRegistry: Record "Registry Files Line";
        UserRequestCount: Integer;
        UserRec: Record "Registry Files Line";
        HODApproval: Boolean;
        RegistryApproval: Boolean;
        User: Record "User Setup";
        FileIssuance: Record "File Issuance";
        RegistryApprovals: Record "Registry Requests Approval";
}

