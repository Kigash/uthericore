page 57066 "Field Coll Trans List Posted"
{
    Caption = 'Field Coll Transaction List Posted';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Teller Transaction Header";
    SourceTableView = WHERE(Posted = filter(true));
    CardPageId = "Field Coll Trans Card";
    layout
    {
        area(Content)
        {
            repeater(Teller)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                }
                field("Member No."; Rec."Member No.")
                {

                }
                field("Member Name"; Rec."Member Name")
                {

                }
                field("Total Line  Amount"; Rec."Total Line Amount")
                {
                    ApplicationArea = All;

                }
                field("Transaction Date"; Rec."Transaction Date")
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

    trigger OnOpenPage()
    begin
        Rec.SetFilter("Teller User ID", UserId);
    end;
}