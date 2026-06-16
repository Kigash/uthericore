page 50286 "Payout List-Posted"
{
    // version TL2.0

    Caption = 'Posted Payouts';
    CardPageID = Payout;
    PageType = List;
    SourceTable = "Payout Header";
    SourceTableView = WHERE(Status = FILTER(Approved),
                            Posted = FILTER(true));
    UsageCategory = History;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Payout Type"; Rec."Payout Type")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Agent Code"; Rec."Agent Code")
                {
                    ApplicationArea = All;
                }
                field("Agent Name"; Rec."Agent Name")
                {
                    ApplicationArea = All;
                }
                field("Total Payout Amount"; Rec."Total Payout Amount")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

