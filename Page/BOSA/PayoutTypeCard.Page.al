page 50287 "Payout Type Card"
{
    // version TL2.0

    PageType = Card;
    SourceTable = "Payout Type";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
            part("Priority Posting"; "Priority Posting")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD(Code);
            }
            // part(Page; 50289)
            // {
            //     ApplicationArea = All;
            //     SubPageLink = "Payout Code" = FIELD(Code);
            // }
        }
    }

    actions
    {
    }
}

