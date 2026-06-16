page 50099 "Teller Ret. Treasury-Posted"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Teller Return Treasury";
    SourceTableView = where(Status = filter(Approved), Posted = filter(true));
    CardPageId = 50094;
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(TellerReturnTreasury)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;

                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = All;

                }
                field("Transaction Time"; Rec."Transaction Time")
                {
                    ApplicationArea = All;

                }
                field("Teller User ID"; Rec."Teller User ID")
                {
                    ApplicationArea = All;

                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}