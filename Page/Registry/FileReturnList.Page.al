page 50968 "File Return List"
{
    // version TL2.0

    CardPageID = "File Return Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "File Return";
    SourceTableView = WHERE(Posted = filter('Yes'),
                            "File Return Status" = filter('Pending Acceptance'));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Return ID"; Rec."Return ID")
                {
                    ApplicationArea = All;
                }
                field("Return Date"; Rec."Return Date")
                {
                    ApplicationArea = All;
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    ApplicationArea = All;
                }
                field("Request ID"; Rec."Request ID")
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
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage();
    begin
        CurrPage.EDITABLE(FALSE);
        User.GET(USERID);
        //SETRANGE("Branch Code",User."Global Dimension 1 Code");
    end;

    var
        User: Record "User Setup";
}

