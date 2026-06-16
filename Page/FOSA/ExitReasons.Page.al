page 50236 "Exit Reasons"
{
    // version TL2.0

    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Setup,Related Information,Posting,Category7';
    SourceTable = "Exit Reason";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Notice Period"; Rec."Notice Period")
                {
                    ApplicationArea = All;
                }
                field("Initiate Refund"; Rec."Initiate Refund")
                {
                    ApplicationArea = All;
                }
                field("Initiate Claim"; Rec."Initiate Claim")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("Fees Setup")
            {
                Image = Costs;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "Exit Reason Fees";
                RunPageLink = "Reason Code" = FIELD(Code);
            }
        }
    }
}

