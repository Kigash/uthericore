page 50560 "Mobile Charge GL Setup List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Mobile Charge GL Setup";
    Caption = 'Mobile Charge GL Setup';
    CardPageId = "Mobile Charge GL Setup Card";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Branch Code"; Rec."Branch Code")
                {
                    ApplicationArea = All;
                }
                field("Branch Name"; Rec."Branch Name")
                {
                    ApplicationArea = All;
                }
                field("Registration GL Account"; Rec."Registration GL Account")
                {
                    ApplicationArea = All;
                }
                field("Penalty GL Account"; Rec."Penalty GL Account")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action(Card)
            {
                Caption = 'Card';
                Image = Card;
                RunObject = page "Mobile Charge GL Setup Card";
                RunPageOnRec = true;
                ApplicationArea = All;
            }
        }
    }
}
