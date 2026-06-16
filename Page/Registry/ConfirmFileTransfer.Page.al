page 55706 "Confirm File Transfer"
{
    // version CBS-TL,REG

    CardPageID = "Transfer Files Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "Transfer Registry File";
    SourceTableView = WHERE(Status = CONST("Pending Receipt"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transfer ID"; Rec."Transfer ID")
                {
                }
                field("Time Released"; Rec."Time Released")
                {
                }
                field("Released From"; Rec."Released From")
                {
                }
                field("Released To"; Rec."Released To")
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
        Rec.FILTERGROUP(2);
        Rec.SETRANGE("Released To", USERID);
        Rec.FILTERGROUP(0);
        CurrPage.EDITABLE(FALSE);
    end;

    var
        User: Record "User Setup";
}

