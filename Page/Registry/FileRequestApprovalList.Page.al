page 55708 "File Request Approval List"
{
    // version CBS-TL,REG

    CardPageID = "File Request Approval Card";
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "File Issuance";
    SourceTableView = WHERE("Request Status" = CONST("Pending Approval"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Request ID"; Rec."Request ID")
                {
                }
                field("Request Date"; Rec."Request Date")
                {
                }
                field("Required Date"; Rec."Required Date")
                {
                }
                field("Duration Required(Days)"; Rec."Duration Required(Days)")
                {
                }
                field("Due Date"; Rec."Due Date")
                {
                }
                field("Requisiton By"; Rec."Requisiton By")
                {
                }
                field(Reason; Rec.Reason)
                {
                }
                field("Request Status"; Rec."Request Status")
                {
                }
                field("Approver ID"; Rec."Approver ID")
                {
                }
                field("Approval Comment"; Rec."Approval Comment")
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
        //SETRANGE("HOD Approver",USERID);
        Rec.FILTERGROUP(2);
        //SETRANGE("Branch Code",User."Global Dimension 1 Code");
        Rec.FILTERGROUP(2);
    end;

    var
        User: Record "User Setup";
}

