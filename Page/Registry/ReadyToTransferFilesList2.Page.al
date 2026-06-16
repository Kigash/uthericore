page 55701 "Ready To Transfer Files List2"
{
    // version CBS-TL,REG

    CardPageID = "Ready For Transfer File Card";
    PageType = List;
    SourceTable = "File Movement";
    SourceTableView = WHERE(Status = CONST("Ready For Transfer"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("File Movement ID"; Rec."File Movement ID")
                {
                }
                field("File No."; Rec."File No.")
                {
                }
                field("File Name"; Rec."File Name")
                {
                }
                field("From Location"; Rec."From Location")
                {
                }
                field("To Location"; Rec."To Location")
                {
                }
                field("Request Remarks"; Rec."Request Remarks")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Request Date"; Rec."Request Date")
                {
                }
                field("Approval/Rejection Remarks"; Rec."Approval/Rejection Remarks")
                {
                }
                field("Approved Date"; Rec."Approved Date")
                {
                }
                field("Approver ID"; Rec."Approver ID")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage();
    begin
        User.GET(USERID);
        //SETRANGE("From Location",User."Global Dimension 1 Code");
        DimensionValue.RESET;
        DimensionValue.SETRANGE("Global Dimension No.", 1);
        DimensionValue.SETRANGE(Code, User."Global Dimension 1 Code");
        IF DimensionValue.FIND('-') THEN BEGIN
            userbranch := DimensionValue.Name;
        END;
        //SETRANGE("From Location",User."Global Dimension 1 Code");
        Rec.SETRANGE("From Location", userbranch);
    end;

    var
        User: Record "User Setup";
        DimensionValue: Record "Dimension Value";
        userbranch: Text[20];
}

