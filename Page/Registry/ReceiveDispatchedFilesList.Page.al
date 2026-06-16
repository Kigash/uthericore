page 50977 "Receive Dispatched Files"
{
    // version TL2.0

    CardPageID = "Receive File Card";
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "File Movement";
    SourceTableView = WHERE(Status = filter(Dispatched));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Received; Rec.Received)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("File Movement ID"; Rec."File Movement ID")
                {
                    ApplicationArea = All;
                }
                field("File No."; Rec."File No.")
                {
                    ApplicationArea = All;
                }
                field("File Name"; Rec."File Name")
                {
                    ApplicationArea = All;
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = All;
                }
                field("Cabinet No."; Rec."Cabinet No.")
                {
                    ApplicationArea = All;
                }
                field(Volume; Rec.Volume)
                {
                    ApplicationArea = All;
                }
                field("From Location"; Rec."From Location")
                {
                    ApplicationArea = All;
                }
                field("To Location"; Rec."To Location")
                {
                    ApplicationArea = All;
                }
                field("Request Remarks"; Rec."Request Remarks")
                {
                    ApplicationArea = All;
                }
                field("Released By"; Rec."Released By")
                {
                    ApplicationArea = All;
                }
                field("Released To"; Rec."Released To")
                {
                    ApplicationArea = All;
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = All;
                }
                field("Date Released"; Rec."Date Released")
                {
                    ApplicationArea = All;
                }
                field("Carried By"; Rec."Carried By")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Approval/Rejection Remarks"; Rec."Approval/Rejection Remarks")
                {
                    ApplicationArea = All;
                }
                field("Request Date"; Rec."Request Date")
                {
                    ApplicationArea = All;
                }
                field("Approved Date"; Rec."Approved Date")
                {
                    ApplicationArea = All;
                }
                field("Approver ID"; Rec."Approver ID")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage();
    begin
        /*User.GET(USERID);
        SETRANGE("To Location",User."Global Dimension 1 Code");
        DimensionValue.RESET;
        DimensionValue.SETRANGE("Global Dimension No.",1);
        DimensionValue.SETRANGE(Code,User."Global Dimension 1 Code");
        IF DimensionValue.FIND('-') THEN BEGIN
           userbranch:=DimensionValue.Name;
        END;
        SETRANGE("To Location",userbranch);*/

    end;

    var
        User: Record "User Setup";
        userbranch: Text[20];
    // DimensionValue : Record "349";
}

