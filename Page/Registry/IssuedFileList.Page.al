page 50967 "Issued File List"
{
    // version TL2.0

    CardPageID = "File Issue Card";
    Editable = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "File Issuance";
    SourceTableView = WHERE("Request Status" = CONST(Issued));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Request ID"; Rec."Request ID")
                {
                    ApplicationArea = All;
                }
                field("Request Date"; Rec."Request Date")
                {
                    ApplicationArea = All;
                }
                field("Required Date"; Rec."Required Date")
                {
                    ApplicationArea = All;
                }
                field("Duration Required(Days)"; Rec."Duration Required(Days)")
                {
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                }
                field("Requisiton By"; Rec."Requisiton By")
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
                field(Reason; Rec.Reason)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Request Status"; Rec."Request Status")
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
        //User.GET(USERID);
        //SETRANGE("Branch Code",User."Global Dimension 1 Code");
        Rec.FILTERGROUP(2);
        Rec.SETRANGE("Requisiton By", USERID);
        Rec.FILTERGROUP(0);
    end;

    var
        User: Record "User Setup";
}

