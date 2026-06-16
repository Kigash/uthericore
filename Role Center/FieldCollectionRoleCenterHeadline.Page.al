page 57349 "Field Coll RoleCenter Headline"
{
    PageType = HeadLinePart;

    layout
    {
        area(content)
        {
            field(Headline0; StrSubstNo(text000, GetUser.GetUser()))
            {
                ApplicationArea = All;
                trigger OnDrillDown()
                var
                begin
                    Page.Run(390);
                end;
            }
            field(Headline1; StrSubstNo(text001, Member.Count))
            {
                ApplicationArea = All;
                trigger OnDrillDown()
                var
                begin
                    Page.Run(50012);
                end;
            }
        }
    }

    var
        text000: TextConst ENU = '<qualifier>Welcome</qualifier><payload>Welcome<emphasize> %1 </emphasize></payload>';
        text001: TextConst ENU = '<qualifier>Members</qualifier><payload>You have registered<emphasize> %1 </emphasize>members so far.</payload>';
        //'You have registered %1 members so far';
        text002: TextConst ENU = '<qualifier>Mobile Banking</qualifier><payload><emphasize> %1 </emphasize>members have been onboarded for Mobile Banking</payload>';
        text003: TextConst ENU = '<qualifier>CTS</qualifier><payload><emphasize> %1 </emphasize>members have been issued with Cheque Books</payload>';
        Member: Record Member;
        LoanApplication: Record "Loan Application";
        StandingOrder: Record "Standing Order";
        SpotcashMember: Record "Mobile Banking Member";
        GetUser: Codeunit "Get User";
}